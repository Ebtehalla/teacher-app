"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.callNotification = void 0;
const functions = require("firebase-functions");
const notification_function_1 = require("./notification-function");
exports.callNotification = functions.https.onCall(async (request, response) => {
    try {
        let teacherId = request.teacherId;
        let fromName = request.fromName;
        let token = request.token;
        let userId = request.userId;
        await (0, notification_function_1.startVideoCallNotification)(fromName, token, teacherId, userId);
    }
    catch (error) {
        throw error;
    }
});
//# sourceMappingURL=video-call-functions.js.map