"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.confirmConsultation = exports.rescheduleTimeslot = exports.refundTimeslot = exports.timeslotAdded = void 0;
const functions = require("firebase-functions");
const collections_1 = require("./collections");
const user_service_1 = require("./user-service");
const admin = require("firebase-admin");
const db = admin.firestore();
const { firestore } = require("firebase-admin");
const notificationFunction = require("./notification-function");
exports.timeslotAdded = functions.firestore
    .document("/TimeSlot/{timeSlotId}")
    .onCreate((snapshot, context) => {
    //snapshot.ref.update({ balance: 0 });
    const newValue = snapshot.data();
    if (newValue.repeat === "weekly on the same day and time") {
        console.log("weekly on the same day and time");
    }
    return Promise.resolve();
});
async function refundTimeslot(timeSlotId, refundId) {
    var _a, _b;
    try {
        var timeslotSnapshot = await collections_1.timeSlotCol.doc(timeSlotId).get();
        if (((_a = timeslotSnapshot.data()) === null || _a === void 0 ? void 0 : _a.available) == false &&
            ((_b = timeslotSnapshot.data()) === null || _b === void 0 ? void 0 : _b.charged) == true) {
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
        }
        else {
            throw "timeslot available, not purchase yet";
        }
    }
    catch (error) {
        throw error;
    }
}
exports.refundTimeslot = refundTimeslot;
/** this function will reschedule the timeslot that has been purchase
 * this function get callen in @ClientApp
 */
exports.rescheduleTimeslot = functions.https.onCall(async (request, response) => {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l;
    var timeSlotNow = await collections_1.timeSlotCol.doc(request.timeSlotIdNow).get();
    var timeSlotChanged = await collections_1.timeSlotCol.doc(request.timeslotChanged).get();
    console.log("timeslot now data : " + JSON.stringify(timeSlotNow.data()));
    if (((_a = timeSlotNow.data()) === null || _a === void 0 ? void 0 : _a.status) == "complete") {
        throw new functions.https.HttpsError("unknown", "The appointment has been marked as complete, and cannot be rescheduled");
    }
    if (((_b = timeSlotNow.data()) === null || _b === void 0 ? void 0 : _b.status) == "refund") {
        throw new functions.https.HttpsError("unknown", "The appointment has been refunded, and cannot be rescheduled");
    }
    if (((_c = timeSlotChanged.data()) === null || _c === void 0 ? void 0 : _c.available) == false) {
        throw new functions.https.HttpsError("unknown", "The selected timeslot is no longer available");
    }
    if ((_d = timeSlotNow.data()) === null || _d === void 0 ? void 0 : _d.pastTimeSlot) {
        throw new functions.https.HttpsError("unknown", "The appointment has been rescheduled once, and cannot be rescheduled again");
    }
    //Update Timeslot
    await timeSlotNow.ref.update({
        timeSlot: (_e = timeSlotChanged.data()) === null || _e === void 0 ? void 0 : _e.timeSlot,
        price: (_f = timeSlotChanged.data()) === null || _f === void 0 ? void 0 : _f.price,
        duration: (_g = timeSlotChanged.data()) === null || _g === void 0 ? void 0 : _g.duration,
        pastTimeSlot: (_h = timeSlotNow.data()) === null || _h === void 0 ? void 0 : _h.timeSlot,
        pastDuration: (_j = timeSlotNow.data()) === null || _j === void 0 ? void 0 : _j.duration,
        pastPrice: (_k = timeSlotNow.data()) === null || _k === void 0 ? void 0 : _k.price,
    });
    await timeSlotChanged.ref.update({
        available: false,
        timeSlotChanged: true,
        timeSlotChangedTo: timeSlotNow.id,
    });
    var timeSlotNow2 = await collections_1.timeSlotCol.doc(request.timeSlotIdNow).get();
    var timeSlotChanged2 = await collections_1.timeSlotCol
        .doc(request.request.timeSlotIdNow)
        .get();
    console.log("successfully reschedule appointment");
    console.log("timeslot now data after change : " + JSON.stringify(timeSlotNow2.data()));
    console.log("timeslot changed data after change : " +
        JSON.stringify(timeSlotChanged2.data()));
    await notificationFunction.rescheduleTimeslotNotification((_l = timeSlotNow.data()) === null || _l === void 0 ? void 0 : _l.teacherId);
});
// user confirm consultation complete, give money to teacher & create transaction
exports.confirmConsultation = functions.firestore
    .document("/Order/{orderId}")
    .onUpdate(async (change, context) => {
    var _a, _b, _c;
    const newValue = change.after.data();
    const previousValue = change.before.data();
    if (newValue.status == "success" &&
        previousValue.status == "payment_success") {
        let timeSlot = await collections_1.timeSlotCol.doc(previousValue.timeSlotId).get();
        //increase teacher balance by order ammount
        if (((_a = timeSlot.data()) === null || _a === void 0 ? void 0 : _a.teacher) == undefined) {
            throw new Error("teacherid is undefined");
        }
        collections_1.teacherCol
            .doc((_b = timeSlot.data()) === null || _b === void 0 ? void 0 : _b.teacherId)
            .get()
            .then((querySnapshot) => {
            var _a;
            let teacherBalance = (_a = querySnapshot.data()) === null || _a === void 0 ? void 0 : _a.balance;
            let balanceNow = (teacherBalance += previousValue.amount);
            querySnapshot.ref.update({ balance: balanceNow });
            console.log("balance now : " + balanceNow);
        });
        //get user id by teacher
        const userId = (await (0, user_service_1.getUserByTeacherId)((_c = timeSlot.data()) === null || _c === void 0 ? void 0 : _c.teacherId))
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
//# sourceMappingURL=timeslot-functions.js.map