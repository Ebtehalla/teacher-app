import * as functions from "firebase-functions";
import Stripe from "stripe";
import { teacherCol, orderCol, timeSlotCol, usersCol } from "./collections";
import { CURRENCY } from "./constants";
import { firestore } from "firebase-admin";
import { PaymentMethod, PaymentStatus } from "./payment-functions";
import {
  orderedTimeslotNotification,
  paymentSuccessNotification,
} from "./notification-function";
import { refundCol } from "./collections";
import { refundTimeslot } from "./timeslot-functions";

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: "2022-11-15",
});

/**
 *
 * function when client purchase timeslot, by default we use Stripe payment gateway
 * you can change this to your payment gateway by following the stripe structure of purchaing the timeslot
 */
export const purchaseTimeslot = functions.https.onCall(
  async (request, response) => {
    try {
      const choosedTimeSlot = (
        await timeSlotCol.doc(request.timeSlotId).get()
      ).data();
      if (!choosedTimeSlot) {
        throw "choosed timeslot is not found";
      }
      const paymentIntent = await stripe.paymentIntents.create({
        amount: choosedTimeSlot.price * 100,
        currency: CURRENCY,
        payment_method_types: ["card"],
      });

      await orderCol.add({
        createdAt: firestore.Timestamp.fromDate(new Date()),
        timeSlotId: request.timeSlotId,
        userId: request.userId,
        charged: false,
        stripePaymentId: paymentIntent.id,
        status: PaymentStatus.NotPay,
        paymentMethod: PaymentMethod.Stripe,
      });
      return paymentIntent.client_secret;
    } catch (error) {
      throw error;
    }
  }
);

/**
 * this function is for stripe webhook, when client successfully purchase the timeslot, stripe will call this webhook
 */
export const stripeWebhook = functions.https.onRequest(
  async (request, response) => {
    let event;
    try {
      if (process.env.STRIPE_WEBHOOK_SECRET == undefined) {
        throw new Error(
          "Stripe webhook secret is undefined, please check .env file"
        );
      }
      const stripeWebhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
      event = stripe.webhooks.constructEvent(
        request.rawBody,
        request.headers["stripe-signature"]!,
        stripeWebhookSecret
      );
    } catch (error) {
      console.error("Webhook signature verification failed");
      response.sendStatus(400);
      return;
    }

    switch (event.type) {
      case "payment_intent.succeeded":
        try {
          const amount = request.body.data.object.amount_received / 100;
          const currency = request.body.data.object.currency;
          const linkReceipt =
            request.body.data.object.charges.data[0].receipt_url;

          let order = await orderCol
            .where("stripePaymentId", "==", request.body.data.object.id)
            .get();

          let orderRef = order.docs[0];

          orderRef.ref.update({
            charged: true,
            amount: amount,
            status: PaymentStatus.PaymentSuccess,
            linkReceipt: linkReceipt,
            currency: currency,
          });

          //Get user info who book this timeslot
          let bookByWho = (
            await usersCol.doc(orderRef.data().userId).get()
          ).data();

          const timeSlot = await timeSlotCol
            .doc(orderRef.data().timeSlotId)
            .get();
          const timeSlotData = timeSlot.data();
          if (!timeSlotData) {
            throw "selected timeslot is null or undefined";
          }
          const teacher = await teacherCol.doc(timeSlotData.teacherId).get();
          timeSlot.ref.update({
            charged: true,
            available: false,
            bookByWho: {
              userId: orderRef.data().userId,
              displayName: bookByWho?.displayName,
              photoUrl: bookByWho?.photoUrl ? bookByWho?.photoUrl : "",
            },
            status: "booked",
            teacher: {
              name: teacher.data()?.name,
              picture: teacher.data()?.picture,
              id: teacher.data()?.id,
            },
            purchaseTime: firestore.Timestamp.fromDate(new Date()),
          });
          await orderedTimeslotNotification(teacher.id);
          await paymentSuccessNotification(orderRef.data().userId, orderRef.id);
          console.log("payment success");
          break;
        } catch (error) {
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
  }
);
/** 
by default we use stripe refund system if you use other payment gateway you need to change this function to
you can just follow the structure of the function
*/

export const refundStripe = functions.https.onCall(
  async (request, response) => {
    try {
      const { timeSlotId } = request;
      const orderRef = await orderCol
        .where("timeSlotId", "==", request.timeSlotId)
        .get();
      const order = orderRef.docs[0];
      const refund = await stripe.refunds.create({
        payment_intent: order.data().stripePaymentId,
      });
      if (refund.status === "succeeded") {
        let refundData = await refundCol.add({
          createdAt: firestore.Timestamp.fromDate(new Date()),
          timeSlotId: request.timeSlotId,
          paymentId: order.data().stripePaymentId,
          status: refund.status,
          amount: refund.amount,
          refundId: refund.id,
          currency: refund.currency,
        });
        await refundTimeslot(timeSlotId, refundData.id);
        console.log("refund success : " + JSON.stringify(refund));
      } else {
        throw "refund failed";
      }
    } catch (err) {
      throw err;
    }
  }
);
