import * as functions from "firebase-functions";
import { teacherCol, timeSlotCol } from "./collections";
import { getUserByTeacherId } from "./user-service";
const admin = require("firebase-admin");
const db = admin.firestore();
const { firestore } = require("firebase-admin");
const notificationFunction = require("./notification-function");

export const timeslotAdded = functions.firestore
  .document("/TimeSlot/{timeSlotId}")
  .onCreate((snapshot, context) => {
    //snapshot.ref.update({ balance: 0 });
    const newValue = snapshot.data();
    if (newValue.repeat === "weekly on the same day and time") {
      console.log("weekly on the same day and time");
    }
    return Promise.resolve();
  });

export async function refundTimeslot(timeSlotId: string, refundId: string) {
  try {
    var timeslotSnapshot = await timeSlotCol.doc(timeSlotId).get();
    if (
      timeslotSnapshot.data()?.available == false &&
      timeslotSnapshot.data()?.charged == true
    ) {
      let refundObject = {
        status: "refund",
        refundId: refundId,
      };
      //update Timeslot Status
      await timeslotSnapshot.ref.update(refundObject);
      //update Order collection status
      let orderSnapshot = await db
        .collection("Order")
        .where("timeSlotId", "==", timeSlotId)
        .get();
      let order = orderSnapshot.docs[0];
      order.ref.update(refundObject);

      console.log("update timeslot refund success");
    } else {
      throw "timeslot available, not purchase yet";
    }
  } catch (error) {
    throw error;
  }
}

/** this function will reschedule the timeslot that has been purchase
 * this function get callen in @ClientApp
 */
export const rescheduleTimeslot = functions.https.onCall(
  async (request, response) => {
    var timeSlotNow = await timeSlotCol.doc(request.timeSlotIdNow).get();

    var timeSlotChanged = await timeSlotCol.doc(request.timeslotChanged).get();
    console.log("timeslot now data : " + JSON.stringify(timeSlotNow.data()));

    if (timeSlotNow.data()?.status == "complete") {
      throw new functions.https.HttpsError(
        "unknown",
        "The appointment has been marked as complete, and cannot be rescheduled"
      );
    }
    if (timeSlotNow.data()?.status == "refund") {
      throw new functions.https.HttpsError(
        "unknown",
        "The appointment has been refunded, and cannot be rescheduled"
      );
    }
    if (timeSlotChanged.data()?.available == false) {
      throw new functions.https.HttpsError(
        "unknown",
        "The selected timeslot is no longer available"
      );
    }
    if (timeSlotNow.data()?.pastTimeSlot) {
      throw new functions.https.HttpsError(
        "unknown",
        "The appointment has been rescheduled once, and cannot be rescheduled again"
      );
    }

    //Update Timeslot
    await timeSlotNow.ref.update({
      timeSlot: timeSlotChanged.data()?.timeSlot,
      price: timeSlotChanged.data()?.price,
      duration: timeSlotChanged.data()?.duration,
      pastTimeSlot: timeSlotNow.data()?.timeSlot,
      pastDuration: timeSlotNow.data()?.duration,
      pastPrice: timeSlotNow.data()?.price,
    });
    await timeSlotChanged.ref.update({
      available: false,
      timeSlotChanged: true,
      timeSlotChangedTo: timeSlotNow.id,
    });
    var timeSlotNow2 = await timeSlotCol.doc(request.timeSlotIdNow).get();
    var timeSlotChanged2 = await timeSlotCol
      .doc(request.request.timeSlotIdNow)
      .get();
    console.log("successfully reschedule appointment");
    console.log(
      "timeslot now data after change : " + JSON.stringify(timeSlotNow2.data())
    );
    console.log(
      "timeslot changed data after change : " +
        JSON.stringify(timeSlotChanged2.data())
    );
    await notificationFunction.rescheduleTimeslotNotification(
      timeSlotNow.data()?.teacherId
    );
  }
);

// user confirm consultation complete, give money to teacher & create transaction
export const confirmConsultation = functions.firestore
  .document("/Order/{orderId}")
  .onUpdate(async (change, context) => {
    const newValue = change.after.data();
    const previousValue = change.before.data();

    if (
      newValue.status == "success" &&
      previousValue.status == "payment_success"
    ) {
      let timeSlot = await timeSlotCol.doc(previousValue.timeSlotId).get();
      //increase teacher balance by order ammount
      if (timeSlot.data()?.teacher == undefined) {
        throw new Error("teacherid is undefined");
      }
      teacherCol
        .doc(timeSlot.data()?.teacherId!)
        .get()
        .then((querySnapshot) => {
          let teacherBalance = querySnapshot.data()?.balance;
          let balanceNow = (teacherBalance += previousValue.amount);
          querySnapshot.ref.update({ balance: balanceNow });
          console.log("balance now : " + balanceNow);
        });

      //get user id by teacher
      const userId = (await getUserByTeacherId(timeSlot.data()?.teacherId!))
        .uid;

      //Create Transaction for teacher, that user already comfirm their consultation
      await db.collection("Transaction").add({
        userId: userId,
        amount: previousValue.amount,
        status: "complete",
        type: "payment",
        timeSlot: previousValue.timeSlotId,
        createdAt: firestore.Timestamp.fromDate(new Date()),
      });
    }
  });
