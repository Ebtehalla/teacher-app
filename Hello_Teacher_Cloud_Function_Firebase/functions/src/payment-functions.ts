import * as functions from "firebase-functions";
import { firestore } from "firebase-admin";
import { orderCol, OrderModel, timeSlotCol, usersCol } from "./collections";
import {
  orderedTimeslotNotification,
  paymentSuccessNotification,
} from "./notification-function";
import { HttpsError } from "firebase-functions/v1/https";
import { teacherCol, BookByWho } from "./collections";
import { CURRENCY } from "./constants";

export enum PaymentStatus {
  PaymentSuccess = "payment_success",
  PaymentFail = "payment_failed",
  NotPay = "notPay",
}
export enum OrderPaymentStatus {
  PaymentSuccess = "payment_success",
  PaymentFail = "payment_failed",
}

export enum PaymentMethod {
  Stripe = "stripe",
  Paystack = "paystack",
}

enum TimeSlotStatus {
  booked = "booked",
  refund = "refund",
  cancel = "cancel",
}
type TeacherTimeslot = {
  name: string;
  picture: string;
};

export interface ConfirmPayment {
  orderId: string;
  timeSlotId: string;
  paymentMethod: PaymentMethod;
  paymentStatus: PaymentStatus;
  amount: number;
  currency: string;
  fee: string;
  paymentType: string;
  bookByWho: BookByWho;
  teacher: TeacherTimeslot;
  teacherId: string;
}

/**
 * Confirm payment, confirm the payment made by user, will set the status to booked and add the Appointment to Teacher Tab and client tab,
 * usually this get called when webhook successfully payment get called
 * @param {ConfirmPayment} confirmPayment you need to create new ConfirmPayment object base on previous ordered timeslot
 */
export async function confirmPayment(confirmPayment: ConfirmPayment) {
  try {
    await orderCol.doc(confirmPayment.orderId).update({
      charged: true,
      amount: confirmPayment.amount,
      status: confirmPayment.paymentStatus,
      currency: confirmPayment.currency,
      fee: confirmPayment.fee,
      paymentMethod: confirmPayment.paymentMethod,
      paymentType: confirmPayment.paymentType,
    });
    await timeSlotCol.doc(confirmPayment.timeSlotId).update({
      charged: true,
      available: false,
      bookByWho: confirmPayment.bookByWho,
      status: TimeSlotStatus.booked,
      teacher: confirmPayment.teacher,
      purchaseTime: firestore.Timestamp.fromDate(new Date()),
    });

    await orderedTimeslotNotification(confirmPayment.teacherId);
  } catch (error) {
    throw error;
  }
}
/**
 * create an order with status not pay, later once client successfully made the payment, you can change the order status to pay
 * @param timeSlotId timeslot id that client wanted to buy
 * @param userId user id who buy this timeslot
 * @param orderId you can set order id, you get this from your payment provider, like id transaction or reference id, that later you can use to find this particular order id, usually from webhook
 */
export async function createOrder(
  timeSlotId: string,
  userId: string,
  orderId: string
) {
  try {
    const newOrder = {
      charged: false,
      status: PaymentStatus.NotPay,
      timeSlotId: timeSlotId,
      userId: userId,
      createdAt: firestore.Timestamp.fromDate(new Date()),
    } as OrderModel;

    await orderCol.doc(orderId).create(newOrder);
    console.log("add new order");
  } catch (error) {
    throw error;
  }
}

/**
 * purchase free timeslot, this function get calle by client when the timeslot price is 0
 * if actual price is not 0 will return a https error
 * @param userId string of user id that wanto purchase this timeslot
 * @param timeSlotId timeSlotId that user wanto purchase
 * @return will return true if success success
 */
export const purchaseFreeTimeSlot = functions.https.onCall(
  async (request, response) => {
    try {
      let { userId, timeSlotId } = request;
      let purchasedTimeSlot = await timeSlotCol.doc(timeSlotId).get();
      let purchasedTimeslotData = purchasedTimeSlot.data();
      if (!purchasedTimeslotData) {
        throw new HttpsError(
          "not-found",
          "TimeSlot not found, please check the timeslot again"
        );
      }
      let amount = purchasedTimeslotData.price;
      if (amount > 0) {
        throw new HttpsError(
          "permission-denied",
          "the timeslot price is not 0 or free, please choose another timeslot"
        );
      }

      //Get user info who book this timeslot
      let bookByWho = await usersCol.doc(userId).get();
      let bookByWhoData = bookByWho.data();
      if (!bookByWhoData) {
        throw new HttpsError("not-found", "User book by who not found");
      }
      //Get teacher detail data
      let teacher = await teacherCol.doc(purchasedTimeslotData.teacherId).get();
      let teacherData = teacher.data();

      if (!teacherData) {
        throw new HttpsError("not-found", "Teacher Data not found");
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
        purchaseTime: firestore.Timestamp.fromDate(new Date()),
      });
      const orderData = await orderCol.add({
        createdAt: firestore.Timestamp.fromDate(new Date()),
        timeSlotId: timeSlotId,
        userId: request.userId,
        charged: true,
        stripePaymentId: "",
        amount: amount,
        status: PaymentStatus.PaymentSuccess,
        linkReceipt: "",
        currency: CURRENCY,
      });

      await orderedTimeslotNotification(teacher.id);
      await paymentSuccessNotification(request.userId, orderData.id);
      return true;
    } catch (e) {
      throw e;
    }
  }
);
