import * as functions from "firebase-functions";
//import * as admin from 'firebase-admin';
// const db = admin.firestore();
// const { firestore } = require("firebase-admin");
//const axios = require("axios");
//const axios = require('axios').default;
//Teacher request money withdrawal
import axios from "axios";
import {
  confirmPayment,
  createOrder,
  ConfirmPayment,
  PaymentMethod,
  PaymentStatus,
} from "./payment-functions";
import {
  orderCol,
  BookByWho,
  teacherCol,
  usersCol,
  timeSlotCol,
} from "./collections";

type PaystackPaymentData = {
  authorization_url: string;
  access_code: string;
  reference: string;
};

type PaystackPaymentResponse = {
  status: boolean;
  message: string;
  data: PaystackPaymentData;
};

exports.requestPaystackPaymentUrl = functions.https.onCall(
  async (request, response) => {
    try {
      console.log("timeslot id : " + request.timeSlotId);
      console.log("user id : " + request.userId);
      const selectedTimeslot = await timeSlotCol.doc(request.timeSlotId).get();
      const selectedUser = await usersCol.doc(request.userId).get();
      const axiosConfig = {
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          Authorization:
            "Bearer sk_test_dccfded876ba3838175aafd6beb16a3b0ba43e60",
        },
      };
      const body = {
        email: selectedUser.data()?.email!,
        amount: selectedTimeslot.data()?.price,
        callback_url: "https://standard.paystack.co/close",
      };
      const { data } = await axios.post<PaystackPaymentResponse>(
        "https://api.paystack.co/transaction/initialize",
        body,
        axiosConfig
      );
      await createOrder(
        request.timeSlotId,
        request.userId,
        data.data.reference
      );
      return data.data.authorization_url;
    } catch (e) {
      throw e;
    }
  }
);

exports.paystackWebhook = functions.https.onRequest(
  async (request, response) => {
    try {
      const { amount, currency, fees, channel, reference } = request.body.data;

      const myOrder = await orderCol.doc(reference).get();
      if (myOrder.data() === undefined) {
        throw "order is undefined";
      }
      const timeSlot = await timeSlotCol.doc(myOrder.data()?.timeSlotId!).get();
      const teacher = await teacherCol.doc(timeSlot.data()?.teacherId!).get();
      const user = (await usersCol.doc(myOrder.data()?.userId!).get()).data();

      const bookByWho: BookByWho = {
        displayName: user?.displayName!,
        photoUrl: "",
        userId: myOrder.data()?.userId!,
      };
      const confirmPaymentData: ConfirmPayment = {
        orderId: myOrder.id,
        timeSlotId: timeSlot.id!,
        paymentMethod: PaymentMethod.Paystack,
        paymentStatus: PaymentStatus.PaymentSuccess,
        amount: amount,
        currency: currency,
        fee: fees,
        paymentType: channel,
        bookByWho: bookByWho,
        teacher: {
          name: teacher.data()?.name!,
          picture: teacher.data()?.picture!,
        },
        teacherId: teacher.id,
      };

      await confirmPayment(confirmPaymentData);

      console.log("payment success");
      response.send();
    } catch (err) {
      throw err;
    }
  }
);
