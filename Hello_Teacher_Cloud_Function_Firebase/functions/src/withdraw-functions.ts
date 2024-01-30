import * as functions from "firebase-functions";
import { teacherCol, usersCol } from "./collections";
const admin = require("firebase-admin");
const db = admin.firestore();
const { firestore } = require("firebase-admin");

/**
 * Teacher withdrawal request, this function will get called by @TeacherApp
 * teacher balance will be set to 0 and their request will be put to "WithdrawRequest" collection in firebase,
 * but the status will be pending, admin should send the real balance to the teacher account, and set the withdrawal status to succeed
 */
export const withdrawRequest = functions.firestore
  .document("/WithdrawRequest/{withdrawRequestId}")
  .onCreate(async (snapshot, context) => {
    let userId = snapshot.data().userId;
    console.log("user Id : " + userId);
    console.log("snapshot data : " + JSON.stringify(snapshot.data()));

    let withdrawSettings = await db
      .collection("Settings")
      .doc("withdrawSettings")
      .get();

    const teacherId = (await usersCol.doc(userId).get()).data()?.teacherId;

    console.log("teacher id : " + teacherId);
    if (!teacherId) {
      throw new Error("teacher id is undefined");
    }
    //decrease teacher balance amount
    let teacher = await teacherCol.doc(teacherId).get();

    if (!teacher.exists) {
      throw new Error("teacher data is undefined");
    }

    let teacherBalance = teacher.data()!.balance;

    console.log("balance : " + teacherBalance);
    if (teacherBalance <= 0) {
      snapshot.ref.delete();
      return Promise.reject();
    }
    let adminFee = (teacherBalance / 100) * withdrawSettings.data().percentage;
    let taxCut = (teacherBalance / 100) * withdrawSettings.data().tax;
    let totalAmount = teacherBalance - (adminFee + taxCut);

    await snapshot.ref.update({
      amount: teacherBalance,
      adminFee: adminFee.toFixed(2),
      tax: taxCut.toFixed(2),
      totalWithdraw: totalAmount.toFixed(2),
      status: "pending",
      createdAt: firestore.Timestamp.fromDate(new Date()),
    });

    await teacher.ref.update({ balance: 0 });

    //add transaction
    await db.collection("Transaction").add({
      userId: userId,
      withdrawMethod: snapshot.data().withdrawMethod,
      amount: teacherBalance,
      status: "pending",
      type: "withdraw",
      createdAt: firestore.Timestamp.fromDate(new Date()),
      withdrawRequestId: snapshot.id,
    });

    return Promise.resolve();
  });
