import * as functions from "firebase-functions";
import { startVideoCallNotification } from "./notification-function";
export const callNotification = functions.https.onCall(
  async (request, response) => {
    try {
      let teacherId = request.teacherId;
      let fromName = request.fromName;
      let token = request.token;
      let userId = request.userId;
      await startVideoCallNotification(fromName, token, teacherId, userId);
    } catch (error) {
      throw error;
    }
  }
);
