import { initializeApp } from "firebase-admin/app";
initializeApp();
import { deleteUserPermanently, userAdded } from "./user-functions";
import {
  changeLastMessage,
  changeMessageStatus,
  createChatRoomToTeacher,
  messageNotification,
} from "./chat-functions";
import { deleteTeacherAccount, teacherAdded } from "./teacher-functions";
import { generateToken } from "./agora-functions";
import {
  purchaseTimeslot,
  refundStripe,
  stripeWebhook,
} from "./stripe-functions";
import { confirmConsultation, rescheduleTimeslot } from "./timeslot-functions";
import {
  notificationStartAppointment,
  notificationVideoCallListen,
} from "./notification-function";
import { withdrawRequest } from "./withdraw-functions";
import { purchaseFreeTimeSlot } from "./payment-functions";
import { callNotification } from "./video-call-functions";

exports.userAdded = userAdded;

exports.purchaseTimeslot = purchaseTimeslot;

exports.confirmConsultation = confirmConsultation;

exports.refundTimeslot = refundStripe;

exports.generateToken = generateToken;

exports.stripeWebhook = stripeWebhook;

exports.notificationStartAppointment = notificationStartAppointment;

exports.deleteTeacher = deleteTeacherAccount;

exports.deleteUser = deleteUserPermanently;

exports.teacherAdded = teacherAdded;

exports.rescheduleTimeslot = rescheduleTimeslot;

exports.withdrawRequiest = withdrawRequest;

exports.changeLastMessage = changeLastMessage;

exports.constChangeMessageStatus = changeMessageStatus;

exports.createChatRoomToTeacher = createChatRoomToTeacher;

exports.purchaseFreeTimeSlot = purchaseFreeTimeSlot;

exports.messageNotification = messageNotification;

exports.notificationVideoCallListen = notificationVideoCallListen;

exports.callNotification = callNotification;
