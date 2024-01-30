import * as functions from "firebase-functions";
import { roomsCol, usersCol, teacherCol } from "./collections";
import { getUserByTeacherId } from "./user-service";
import { RoomModel, RoomType } from "./model/chat/roomModel";
import { HttpsError } from "firebase-functions/v1/https";
import { sendNotification } from "./notification-function";
import { AppName } from "./constants";

/** this function will automatically change the room chat with last message
 * this is chat feature
 */
export const changeLastMessage = functions.firestore
  .document("Rooms/{roomId}/messages/{messageId}")
  .onUpdate(async (change, context) => {
    const message = change.after.data();
    if (message) {
      await roomsCol.doc(context.params.roomId).update({
        lastMessages: [message],
      });
    }
  });
/**
 * this function will listen message and if there's new message will send notification to that person
 */
export const messageNotification = functions.firestore
  .document("Rooms/{roomId}/messages/{messageId}")
  .onUpdate(async (change, context) => {
    const message = change.after.data();
    const roomId = context.params.roomId;
    const otherPersonToken = await getUserTokenFromRoom(
      roomId,
      message.authorId
    );
    if (otherPersonToken) {
      await sendNotification(
        otherPersonToken,
        AppName + " Message",
        message.text,
        { roomId: roomId, type: "chat" }
      );
    }
  });

/** function that will change the message status it's delivered or not */
export const changeMessageStatus = functions.firestore
  .document("Rooms/{roomId}/messages/{messageId}")
  .onWrite((change) => {
    const message = change.after.data();
    if (message) {
      if (["delivered", "seen", "sent"].includes(message.status)) {
        return null;
      } else {
        return change.after.ref.update({
          status: "delivered",
        });
      }
    } else {
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
export const createChatRoomToTeacher = functions.https.onCall(
  async (request, context) => {
    try {
      const { userId, teacherId } = request;
      const userData = (await usersCol.doc(userId).get()).data();
      const teacherData = (await teacherCol.doc(teacherId).get()).data();
      const userTeacher = await getUserByTeacherId(teacherId);
      if (userData == undefined) {
        throw new HttpsError(
          "not-found",
          "user data not found, please check the user id"
        );
      }
      if (teacherData == undefined) {
        throw new HttpsError(
          "not-found",
          "teacher data not found, please check the teacher id"
        );
      }
      if (userTeacher == undefined) {
        throw new HttpsError(
          "not-found",
          "user teacher not found, maybe the user is deleted, please check the user in firestore"
        );
      }

      //check if the client already have room with to this teacher
      const listRoomRef = await roomsCol
        .where("userIds", "array-contains", userId)
        .get();
      const listRoom = listRoomRef.docs.map((room) => {
        return { ...room.data(), id: room.id };
      });
      const foundingChat = listRoom.find((data) => {
        if (!data.userIds) return false;
        if (data.userIds.includes(userTeacher.uid)) {
          return true;
        } else {
          return false;
        }
      });

      if (foundingChat != undefined) {
        //there's already room for these user and teacher
        return foundingChat;
      } else {
        //there's no room between this client and teacher, create new room
        const newRoom: Partial<RoomModel> = {
          name: userTeacher.displayName,
          userIds: [userData.uid, userTeacher.uid],
          createdAt: new Date(),
          imageUrl: teacherData?.picture,
          type: RoomType.direct,
          updatedAt: new Date(),
        };
        const roomRef = await roomsCol.add(newRoom);
        return { ...newRoom, id: roomRef.id } as RoomModel;
      }
    } catch (error) {
      throw error;
    }
  }
);

/**
 *TODO this function is not optimize yet, in the future, maybe we need to change the message model to to make it more easy send notification more efficient, becuase
 *TODO everytime wesend the message the data need to retrieve user model and room data
 * inside room, there's two user you need to provide sender id, and this function will return the other person token
 * @param roomId roomId
 * @param senderId senderId, you will get the token from opposite sender id, not token from this sender id, why is tha't you askin
 * it's becaseu of the structure of the message force us to do this, so it's just reverse
 * @returns will return other person token
 */
async function getUserTokenFromRoom(
  roomId: string,
  senderId: string
): Promise<string | string[] | undefined> {
  try {
    const roomData = await roomsCol.doc(roomId).get();
    const otherPersonId = roomData
      .data()
      ?.userIds?.filter((personId) => personId !== senderId)[0];
    if (otherPersonId) {
      const userToken = (await usersCol.doc(otherPersonId).get()).data()?.token;
      return userToken;
    } else {
      return undefined;
    }
  } catch (error) {
    throw error;
  }
}
