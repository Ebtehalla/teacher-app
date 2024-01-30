"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.refundStripe = exports.stripeWebhook = exports.purchaseTimeslot = void 0;
const functions = require("firebase-functions");
const stripe_1 = require("stripe");
const collections_1 = require("./collections");
const constants_1 = require("./constants");
const firebase_admin_1 = require("firebase-admin");
const payment_functions_1 = require("./payment-functions");
const notification_function_1 = require("./notification-function");
const collections_2 = require("./collections");
const timeslot_functions_1 = require("./timeslot-functions");
const stripe = new stripe_1.default(process.env.STRIPE_SECRET_KEY, {
    apiVersion: "2022-11-15",
});
/**
 *
 * function when client purchase timeslot, by default we use Stripe payment gateway
 * you can change this to your payment gateway by following the stripe structure of purchaing the timeslot
 */
exports.purchaseTimeslot = functions.https.onCall(async (request, response) => {
    try {
        const choosedTimeSlot = (await collections_1.timeSlotCol.doc(request.timeSlotId).get()).data();
        if (!choosedTimeSlot) {
            throw "choosed timeslot is not found";
        }
        const paymentIntent = await stripe.paymentIntents.create({
            amount: choosedTimeSlot.price * 100,
            currency: constants_1.CURRENCY,
            payment_method_types: ["card"],
        });
        await collections_1.orderCol.add({
            createdAt: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
            timeSlotId: request.timeSlotId,
            userId: request.userId,
            charged: false,
            stripePaymentId: paymentIntent.id,
            status: payment_functions_1.PaymentStatus.NotPay,
            paymentMethod: payment_functions_1.PaymentMethod.Stripe,
        });
        return paymentIntent.client_secret;
    }
    catch (error) {
        throw error;
    }
});
/**
 * this function is for stripe webhook, when client successfully purchase the timeslot, stripe will call this webhook
 */
exports.stripeWebhook = functions.https.onRequest(async (request, response) => {
    var _a, _b, _c;
    let event;
    try {
        if (process.env.STRIPE_WEBHOOK_SECRET == undefined) {
            throw new Error("Stripe webhook secret is undefined, please check .env file");
        }
        const stripeWebhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
        event = stripe.webhooks.constructEvent(request.rawBody, request.headers["stripe-signature"], stripeWebhookSecret);
    }
    catch (error) {
        console.error("Webhook signature verification failed");
        response.sendStatus(400);
        return;
    }
    switch (event.type) {
        case "payment_intent.succeeded":
            try {
                const amount = request.body.data.object.amount_received / 100;
                const currency = request.body.data.object.currency;
                const linkReceipt = request.body.data.object.charges.data[0].receipt_url;
                let order = await collections_1.orderCol
                    .where("stripePaymentId", "==", request.body.data.object.id)
                    .get();
                let orderRef = order.docs[0];
                orderRef.ref.update({
                    charged: true,
                    amount: amount,
                    status: payment_functions_1.PaymentStatus.PaymentSuccess,
                    linkReceipt: linkReceipt,
                    currency: currency,
                });
                //Get user info who book this timeslot
                let bookByWho = (await collections_1.usersCol.doc(orderRef.data().userId).get()).data();
                const timeSlot = await collections_1.timeSlotCol
                    .doc(orderRef.data().timeSlotId)
                    .get();
                const timeSlotData = timeSlot.data();
                if (!timeSlotData) {
                    throw "selected timeslot is null or undefined";
                }
                const teacher = await collections_1.teacherCol.doc(timeSlotData.teacherId).get();
                timeSlot.ref.update({
                    charged: true,
                    available: false,
                    bookByWho: {
                        userId: orderRef.data().userId,
                        displayName: bookByWho === null || bookByWho === void 0 ? void 0 : bookByWho.displayName,
                        photoUrl: (bookByWho === null || bookByWho === void 0 ? void 0 : bookByWho.photoUrl) ? bookByWho === null || bookByWho === void 0 ? void 0 : bookByWho.photoUrl : "",
                    },
                    status: "booked",
                    teacher: {
                        name: (_a = teacher.data()) === null || _a === void 0 ? void 0 : _a.name,
                        picture: (_b = teacher.data()) === null || _b === void 0 ? void 0 : _b.picture,
                        id: (_c = teacher.data()) === null || _c === void 0 ? void 0 : _c.id,
                    },
                    purchaseTime: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
                });
                await (0, notification_function_1.orderedTimeslotNotification)(teacher.id);
                await (0, notification_function_1.paymentSuccessNotification)(orderRef.data().userId, orderRef.id);
                console.log("payment success");
                break;
            }
            catch (error) {
                console.log("error " + error);
            }
        case "payment_intent.canceled":
            console.log("failed payment ");
            break;
        // ... handle other event types
        default:
            console.log(`Unhandled event type ${event.type}`);
    }
    // Return a 200 response to acknowledge receipt of the event
    response.send();
});
/**
by default we use stripe refund system if you use other payment gateway you need to change this function to
you can just follow the structure of the function
*/
exports.refundStripe = functions.https.onCall(async (request, response) => {
    try {
        const { timeSlotId } = request;
        const orderRef = await collections_1.orderCol
            .where("timeSlotId", "==", request.timeSlotId)
            .get();
        const order = orderRef.docs[0];
        const refund = await stripe.refunds.create({
            payment_intent: order.data().stripePaymentId,
        });
        if (refund.status === "succeeded") {
            let refundData = await collections_2.refundCol.add({
                createdAt: firebase_admin_1.firestore.Timestamp.fromDate(new Date()),
                timeSlotId: request.timeSlotId,
                paymentId: order.data().stripePaymentId,
                status: refund.status,
                amount: refund.amount,
                refundId: refund.id,
                currency: refund.currency,
            });
            await (0, timeslot_functions_1.refundTimeslot)(timeSlotId, refundData.id);
            console.log("refund success : " + JSON.stringify(refund));
        }
        else {
            throw "refund failed";
        }
    }
    catch (err) {
        throw err;
    }
});
//# sourceMappingURL=stripe-functions.js.map