"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.purchaseFreeTimeSlot = exports.createOrder = exports.confirmPayment = exports.PaymentMethod = exports.OrderPaymentStatus = exports.PaymentStatus = void 0;
const functions = require("firebase-functions");
const firebase_admin_1 = require("firebase-admin");
const collections_1 = require("./collections");
const notification_function_1 = require("./notification-function");
const https_1 = require("firebase-functions/v1/https");
const collections_2 = require("./collections");
const constants_1 = require("./constants");
var PaymentStatus;
(function (PaymentStatus) {
    PaymentStatus["PaymentSuccess"] = "payment_success";
    PaymentStatus["PaymentFail"] = "payment_failed";
    PaymentStatus["NotPay"] = "notPay";
})(PaymentStatus = exports.PaymentStatus || (exports.PaymentStatus = {}));
var OrderPaymentStatus;
(function (OrderPaymentStatus) {
    OrderPaymentStatus["PaymentSuccess"] = "payment_success";
    OrderPaymentStatus["PaymentFail"] = "payment_failed";
})(OrderPaymentStatus = exports.OrderPaymentStatus || (exports.OrderPaymentStatus = {}));
var PaymentMethod;
(function (PaymentMethod) {
    PaymentMethod["Stripe"] = "stripe";
    PaymentMethod["Paystack"] = "paystack";
})(PaymentMethod = exports.PaymentMethod || (exports.PaymentMethod = {}));
var TimeSlotStatus;
(function (TimeSlotStatus) {
    TimeSlotStatus["booked"] = "booked";
    TimeSlotStatus["refund"] = "refund";
    TimeSlotStatus["cancel"] = "cancel";
})(TimeSlotStatus || (TimeSlotStatus = {}));
/**
 * Confirm payment, confirm the payment made by user, will set the status to booked and add the Appointment to Teacher Tab and client tab,
 * usually this get called when webhook successfully payment get called
 * @param {ConfirmPayment} confirmPayment you need to create new ConfirmPayment object base on previous ordered timeslot
 */
async function confirmPayment(confirmPayment) {
    try {
        await collections_1.orderCol.doc(confirmPayment.orderId).update({
            charged: true,
            amount: confirmPayment.amount,
            status: confirmPayment.paymentStatus,
            currency: confirmPayment.currency,
            fee: confirmPayment.fee,
            paymentMethod: confirmPayment.paymentMethod,
            paymentType: confirmPayment.paymentType,
        });
        await collections_1.timeSlotCol.doc(confirmPayment.timeSlotId).update({
            charged: true,
            available: false,
            bookByWho: confirmPayment.bookByWho,
            status: TimeSlotStatus.booked,
            teacher: confirmPayment.teacher,
            purchaseTime: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
        });
        await (0, notification_function_1.orderedTimeslotNotification)(confirmPayment.teacherId);
    }
    catch (error) {
        throw error;
    }
}
exports.confirmPayment = confirmPayment;
/**
 * create an order with status not pay, later once client successfully made the payment, you can change the order status to pay
 * @param timeSlotId timeslot id that client wanted to buy
 * @param userId user id who buy this timeslot
 * @param orderId you can set order id, you get this from your payment provider, like id transaction or reference id, that later you can use to find this particular order id, usually from webhook
 */
async function createOrder(timeSlotId, userId, orderId) {
    try {
        const newOrder = {
            charged: false,
            status: PaymentStatus.NotPay,
            timeSlotId: timeSlotId,
            userId: userId,
            createdAt: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
        };
        await collections_1.orderCol.doc(orderId).create(newOrder);
        console.log("add new order");
    }
    catch (error) {
        throw error;
    }
}
exports.createOrder = createOrder;
/**
 * purchase free timeslot, this function get calle by client when the timeslot price is 0
 * if actual price is not 0 will return a https error
 * @param userId string of user id that wanto purchase this timeslot
 * @param timeSlotId timeSlotId that user wanto purchase
 * @return will return true if success success
 */
exports.purchaseFreeTimeSlot = functions.https.onCall(async (request, response) => {
    try {
        let { userId, timeSlotId } = request;
        let purchasedTimeSlot = await collections_1.timeSlotCol.doc(timeSlotId).get();
        let purchasedTimeslotData = purchasedTimeSlot.data();
        if (!purchasedTimeslotData) {
            throw new https_1.HttpsError("not-found", "TimeSlot not found, please check the timeslot again");
        }
        let amount = purchasedTimeslotData.price;
        if (amount > 0) {
            throw new https_1.HttpsError("permission-denied", "the timeslot price is not 0 or free, please choose another timeslot");
        }
        //Get user info who book this timeslot
        let bookByWho = await collections_1.usersCol.doc(userId).get();
        let bookByWhoData = bookByWho.data();
        if (!bookByWhoData) {
            throw new https_1.HttpsError("not-found", "User book by who not found");
        }
        //Get teacher detail data
        let teacher = await collections_2.teacherCol.doc(purchasedTimeslotData.teacherId).get();
        let teacherData = teacher.data();
        if (!teacherData) {
            throw new https_1.HttpsError("not-found", "Teacher Data not found");
        }
        await purchasedTimeSlot.ref.update({
            charged: true,
            available: false,
            bookByWho: {
                userId: userId,
                displayName: bookByWhoData.displayName,
                photoUrl: bookByWhoData.photoUrl ? bookByWhoData.photoUrl : "",
            },
            status: TimeSlotStatus.booked,
            teacher: {
                id: teacherData.id,
                name: teacherData.name,
                picture: teacherData.picture,
            },
            purchaseTime: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
        });
        const orderData = await collections_1.orderCol.add({
            createdAt: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
            timeSlotId: timeSlotId,
            userId: request.userId,
            charged: true,
            stripePaymentId: "",
            amount: amount,
            status: PaymentStatus.PaymentSuccess,
            linkReceipt: "",
            currency: constants_1.CURRENCY,
        });
        await (0, notification_function_1.orderedTimeslotNotification)(teacher.id);
        await (0, notification_function_1.paymentSuccessNotification)(request.userId, orderData.id);
        return true;
    }
    catch (e) {
        throw e;
    }
});
//# sourceMappingURL=payment-functions.js.map