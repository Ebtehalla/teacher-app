import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { getUserByTeacherId, getUserTokenById } from "./user-service";
import { timeSlotCol } from "./collections";

/**
 * this function get called by teacher,
 * send notification to user when appointment is start by the teacher
 */

export const notificationStartAppointment = functions.https.onCall(
  async (request, response) => {
    console.log("Start appointment notification send");
    const { name, roomName, token, timeSlotId } = request;
    let userId = request.userId;
    let userToken = await getUserTokenById(userId); //await userService.getUserTokenById(userId);
    console.log("token user : " + userToken);
    await sendVideoCallNotification(roomName, name, token, userId, timeSlotId);
    await sendNotification(
      userToken,
      `Hi. ${name} has started the consultation session`,
      "Please join the room, to start the consultation session"
    );
  }
);
/**
 * notification for teacher that their timeslot is get ordered
 * @param {string} teacherId teacher id which has the timeslot that get ordered
 */
export async function orderedTimeslotNotification(teacherId: string) {
  try {
    let teacherUser = await getUserByTeacherId(teacherId);
    await sendNotification(
      teacherUser.token,
      "Timeslot has been ordered!",
      "one of your timeslots has been ordered!"
    );
  } catch (error) {
    throw error;
  }
}
/**
 * notification for client that their payment is succefully
 * @param {string} clientId client id that will be sent the notification message
 */
export async function paymentSuccessNotification(
  userId: string,
  orderId: string
) {
  try {
    let userToken = await getUserTokenById(userId);
    console.log("Success payment notification user token : " + userToken);
    console.log("Success payment notification user id : " + userId);
    await sendNotification(
      userToken,
      "Payment Successful!",
      `Thank you, your payment has been successfully received! with order id ${orderId}`
    );
  } catch (error) {
    throw error;
  }
}

/**
 * send notification to teacher, when timeslot is reschedule
 * @param teacherId the teacher id
 */
export async function rescheduleTimeslotNotification(teacherId: string) {
  try {
    let teacherUser = await getUserByTeacherId(teacherId);
    await sendNotification(
      teacherUser.token,
      "Reschedule Appointment",
      "one of your timeslots has been rescheduled"
    );
  } catch (error) {
    console.log(error);
  }
}

/**
sending the notification
 * @param  {string} token user token you wanto send the notification
 * @param  {string} title notification title
 * @param  {string} message notification message to send
 */
export async function sendNotification(
  token: string | string[],
  title: string,
  message: string,
  data?: any
) {
  try {
    const payload = {
      notification: {
        title: title,
        body: message,
      },
      data: data,
    };
    let response = await admin.messaging().sendToDevice(token, payload);
    console.log("Successfully send notification: ", response);
  } catch (error) {
    console.log("Error send notification :", error);
  }
}

/**
send video call notification to user
 * @param  {string} roomName
 * @param  {string} fromName
 * @param  {string} agoraToken agora.io token room
 * @param  {string} userId
 * @param  {string} timeSlotId
 */
export async function sendVideoCallNotification(
  roomName: string,
  fromName: string,
  agoraToken: string,
  userId: string,
  timeSlotId: string
) {
  try {
    let title = `${fromName} have started the meeting`;
    let body = `please join the meeting, ${fromName} already waiting for you`;
    const payload = {
      notification: {
        title: title,
        body: body,
      },
      data: {
        personSent: fromName,
        type: "call",
        roomName: roomName,
        fromName: fromName,
        token: agoraToken,
        timeSlotId: timeSlotId,
      },
    };
    console.log("user id : " + userId);
    let userToken = await getUserTokenById(userId);
    console.log("user token : " + userToken);
    console.log("payload : " + JSON.stringify(payload));
    admin
      .messaging()
      .sendToDevice(userToken, payload)
      .then(function (response) {
        console.log("Successfully send notification: ", response);
      })
      .catch(function (error) {
        console.log("Error send notification :", error);
      });
  } catch (error) {
    throw error;
  }
}

export const startVideoCallNotification = async (
  fromName: string,
  agoraToken: string,
  teacherId: string,
  userId: string
) => {
  try {
    let title = "Call";
    let body = `${fromName} Calling`;
    const payload = {
      notification: {
        title: title,
        body: body,
      },
      data: {
        type: "call",
        fromName: fromName,
        token: agoraToken,
        userId: userId,
      },
    };
    let teacherUser = await getUserByTeacherId(teacherId);
    let teacherToken = await getUserTokenById(teacherUser.uid);
    await admin.messaging().sendToDevice(teacherToken, payload);
  } catch (error) {
    throw error;
  }
};

/** this function will listen room video call that get create  by teacher, and send notification to the user
 * this notification video call feature
 */
export const notificationVideoCallListen = functions.firestore
  .document("RoomVideoCall/{roomVideoCallId}")
  .onCreate(async (snapshot, context) => {
    const roomVideoCall = snapshot.data();
    const timeSlotId = context.params.roomVideoCallId;
    const timeSlotData = (await timeSlotCol.doc(timeSlotId).get()).data();
    console.log("timeslot data : " + JSON.stringify(timeSlotData));
    if (timeSlotData?.bookByWho?.userId) {
      const userToken = await getUserTokenById(timeSlotData?.bookByWho.userId);
      console.log("user token : " + userToken);
      console.log("room video call data : " + JSON.stringify(roomVideoCall));
      const name = timeSlotData.teacher?.name;
      await sendNotification(
        userToken,
        `${name} have started the meeting`,
        `please join the meeting, ${name} already waiting for you`
      );
    } else {
      throw Error(
        "user id in timeslot data is null, cannot get the user token to send the video call notification"
      );
    }
  });
