"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createChatRoomToTeacher = exports.changeMessageStatus = exports.messageNotification = exports.changeLastMessage = void 0;
const functions = require("firebase-functions");
const collections_1 = require("./collections");
const user_service_1 = require("./user-service");
const roomModel_1 = require("./model/chat/roomModel");
const https_1 = require("firebase-functions/v1/https");
const notification_function_1 = require("./notification-function");
const constants_1 = require("./constants");
/** this function will automatically change the room chat with last message
 * this is chat feature
 */
exports.changeLastMessage = functions.firestore
    .document("Rooms/{roomId}/messages/{messageId}")
    .onUpdate(async (change, context) => {
    const message = change.after.data();
    if (message) {
        await collections_1.roomsCol.doc(context.params.roomId).update({
            lastMessages: [message],
        });
    }
});
/**
 * this function will listen message and if there's new message will send notification to that person
 */
exports.messageNotification = functions.firestore
    .document("Rooms/{roomId}/messages/{messageId}")
    .onUpdate(async (change, context) => {
    const message = change.after.data();
    const roomId = context.params.roomId;
    const otherPersonToken = await getUserTokenFromRoom(roomId, message.authorId);
    if (otherPersonToken) {
        await (0, notification_function_1.sendNotification)(otherPersonToken, constants_1.AppName + " Message", message.text, { roomId: roomId, type: "chat" });
    }
});
/** function that will change the message status it's delivered or not */
exports.changeMessageStatus = functions.firestore
    .document("Rooms/{roomId}/messages/{messageId}")
    .onWrite((change) => {
    const message = change.after.data();
    if (message) {
        if (["delivered", "seen", "sent"].includes(message.status)) {
            return null;
        }
        else {
            return change.after.ref.update({
                status: "delivered",
            });
        }
    }
    else {
        return null;
    }
});
/**
 * Create chat room between client and teacher, this function specifically design for client only
 * @param userId {string} userId that wantedTo create roomchat
 * @param teacherId {string} teacherId client wanto chat with
 * @returns will return room object
 * @todo right now there's no checking method if there's alredy room between this two
 * right now checking only implemented in client, so if you call this it will automatically create new room between thesetwo user
 * which mean there's two room between these two client so in the future, we need to handle if there's already room bethween these two user
 */
exports.createChatRoomToTeacher = functions.https.onCall(async (request, context) => {
    try {
        const { userId, teacherId } = request;
        const userData = (await collections_1.usersCol.doc(userId).get()).data();
        const teacherData = (await collections_1.teacherCol.doc(teacherId).get()).data();
        const userTeacher = await (0, user_service_1.getUserByTeacherId)(teacherId);
        if (userData == undefined) {
            throw new https_1.HttpsError("not-found", "user data not found, please check the user id");
        }
        if (teacherData == undefined) {
            throw new https_1.HttpsError("not-found", "teacher data not found, please check the teacher id");
        }
        if (userTeacher == undefined) {
            throw new https_1.HttpsError("not-found", "user teacher not found, maybe the user is deleted, please check the user in firestore");
        }
        //check if the client already have room with to this teacher
        const listRoomRef = await collections_1.roomsCol
            .where("userIds", "array-contains", userId)
            .get();
        const listRoom = listRoomRef.docs.map((room) => {
            return Object.assign(Object.assign({}, room.data()), { id: room.id });
        });
        const foundingChat = listRoom.find((data) => {
            if (!data.userIds)
                return false;
            if (data.userIds.includes(userTeacher.uid)) {
                return true;
            }
            else {
                return false;
            }
        });
        if (foundingChat != undefined) {
            //there's already room for these user and teacher
            return foundingChat;
        }
        else {
            //there's no room between this client and teacher, create new room
            const newRoom = {
                name: userTeacher.displayName,
                userIds: [userData.uid, userTeacher.uid],
                createdAt: new Date(),
                imageUrl: teacherData === null || teacherData === void 0 ? void 0 : teacherData.picture,
                type: roomModel_1.RoomType.direct,
                updatedAt: new Date(),
            };
            const roomRef = await collections_1.roomsCol.add(newRoom);
            return Object.assign(Object.assign({}, newRoom), { id: roomRef.id });
        }
    }
    catch (error) {
        throw error;
    }
});
/**
 *TODO this function is not optimize yet, in the future, maybe we need to change the message model to to make it more easy send notification more efficient, becuase
 *TODO everytime wesend the message the data need to retrieve user model and room data
 * inside room, there's two user you need to provide sender id, and this function will return the other person token
 * @param roomId roomId
 * @param senderId senderId, you will get the token from opposite sender id, not token from this sender id, why is tha't you askin
 * it's becaseu of the structure of the message force us to do this, so it's just reverse
 * @returns will return other person token
 */
async function getUserTokenFromRoom(roomId, senderId) {
    var _a, _b, _c;
    try {
        const roomData = await collections_1.roomsCol.doc(roomId).get();
        const otherPersonId = (_b = (_a = roomData
            .data()) === null || _a === void 0 ? void 0 : _a.userIds) === null || _b === void 0 ? void 0 : _b.filter((personId) => personId !== senderId)[0];
        if (otherPersonId) {
            const userToken = (_c = (await collections_1.usersCol.doc(otherPersonId).get()).data()) === null || _c === void 0 ? void 0 : _c.token;
            return userToken;
        }
        else {
            return undefined;
        }
    }
    catch (error) {
        throw error;
    }
}
//# sourceMappingURL=chat-functions.js.map