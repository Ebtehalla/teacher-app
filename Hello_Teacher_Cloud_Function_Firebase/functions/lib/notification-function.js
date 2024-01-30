"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.notificationVideoCallListen = exports.startVideoCallNotification = exports.sendVideoCallNotification = exports.sendNotification = exports.rescheduleTimeslotNotification = exports.paymentSuccessNotification = exports.orderedTimeslotNotification = exports.notificationStartAppointment = void 0;
const admin = require("firebase-admin");
const functions = require("firebase-functions");
const user_service_1 = require("./user-service");
const collections_1 = require("./collections");
/**
 * this function get called by teacher,
 * send notification to user when appointment is start by the teacher
 */
exports.notificationStartAppointment = functions.https.onCall(async (request, response) => {
    console.log("Start appointment notification send");
    const { name, roomName, token, timeSlotId } = request;
    let userId = request.userId;
    let userToken = await (0, user_service_1.getUserTokenById)(userId); //await userService.getUserTokenById(userId);
    console.log("token user : " + userToken);
    await sendVideoCallNotification(roomName, name, token, userId, timeSlotId);
    await sendNotification(userToken, `Hi. ${name} has started the consultation session`, "Please join the room, to start the consultation session");
});
/**
 * notification for teacher that their timeslot is get ordered
 * @param {string} teacherId teacher id which has the timeslot that get ordered
 */
async function orderedTimeslotNotification(teacherId) {
    try {
        let teacherUser = await (0, user_service_1.getUserByTeacherId)(teacherId);
        await sendNotification(teacherUser.token, "Timeslot has been ordered!", "one of your timeslots has been ordered!");
    }
    catch (error) {
        throw error;
    }
}
exports.orderedTimeslotNotification = orderedTimeslotNotification;
/**
 * notification for client that their payment is succefully
 * @param {string} clientId client id that will be sent the notification message
 */
async function paymentSuccessNotification(userId, orderId) {
    try {
        let userToken = await (0, user_service_1.getUserTokenById)(userId);
        console.log("Success payment notification user token : " + userToken);
        console.log("Success payment notification user id : " + userId);
        await sendNotification(userToken, "Payment Successful!", `Thank you, your payment has been successfully received! with order id ${orderId}`);
    }
    catch (error) {
        throw error;
    }
}
exports.paymentSuccessNotification = paymentSuccessNotification;
/**
 * send notification to teacher, when timeslot is reschedule
 * @param teacherId the teacher id
 */
async function rescheduleTimeslotNotification(teacherId) {
    try {
        let teacherUser = await (0, user_service_1.getUserByTeacherId)(teacherId);
        await sendNotification(teacherUser.token, "Reschedule Appointment", "one of your timeslots has been rescheduled");
    }
    catch (error) {
        console.log(error);
    }
}
exports.rescheduleTimeslotNotification = rescheduleTimeslotNotification;
/**
sending the notification
 * @param  {string} token user token you wanto send the notification
 * @param  {string} title notification title
 * @param  {string} message notification message to send
 */
async function sendNotification(token, title, message, data) {
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
    }
    catch (error) {
        console.log("Error send notification :", error);
    }
}
exports.sendNotification = sendNotification;
/**
send video call notification to user
 * @param  {string} roomName
 * @param  {string} fromName
 * @param  {string} agoraToken agora.io token room
 * @param  {string} userId
 * @param  {string} timeSlotId
 */
async function sendVideoCallNotification(roomName, fromName, agoraToken, userId, timeSlotId) {
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
        let userToken = await (0, user_service_1.getUserTokenById)(userId);
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
    }
    catch (error) {
        throw error;
    }
}
exports.sendVideoCallNotification = sendVideoCallNotification;
const startVideoCallNotification = async (fromName, agoraToken, teacherId, userId) => {
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
        let teacherUser = await (0, user_service_1.getUserByTeacherId)(teacherId);
        let teacherToken = await (0, user_service_1.getUserTokenById)(teacherUser.uid);
        await admin.messaging().sendToDevice(teacherToken, payload);
    }
    catch (error) {
        throw error;
    }
};
exports.startVideoCallNotification = startVideoCallNotification;
/** this function will listen room video call that get create  by teacher, and send notification to the user
 * this notification video call feature
 */
exports.notificationVideoCallListen = functions.firestore
    .document("RoomVideoCall/{roomVideoCallId}")
    .onCreate(async (snapshot, context) => {
    var _a, _b;
    const roomVideoCall = snapshot.data();
    const timeSlotId = context.params.roomVideoCallId;
    const timeSlotData = (await collections_1.timeSlotCol.doc(timeSlotId).get()).data();
    console.log("timeslot data : " + JSON.stringify(timeSlotData));
    if ((_a = timeSlotData === null || timeSlotData === void 0 ? void 0 : timeSlotData.bookByWho) === null || _a === void 0 ? void 0 : _a.userId) {
        const userToken = await (0, user_service_1.getUserTokenById)(timeSlotData === null || timeSlotData === void 0 ? void 0 : timeSlotData.bookByWho.userId);
        console.log("user token : " + userToken);
        console.log("room video call data : " + JSON.stringify(roomVideoCall));
        const name = (_b = timeSlotData.teacher) === null || _b === void 0 ? void 0 : _b.name;
        await sendNotification(userToken, `${name} have started the meeting`, `please join the meeting, ${name} already waiting for you`);
    }
    else {
        throw Error("user id in timeslot data is null, cannot get the user token to send the video call notification");
    }
});
//# sourceMappingURL=notification-function.js.map