"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateToken = void 0;
const { RtcTokenBuilder, RtcRole } = require("agora-access-token");
const functions = require("firebase-functions");
/**
 * this function is for agora to generate token, when teacher try to create room to start video call, this function will call agora
 * to get the agora token, make sure you have setup the agora app id and agora certificate to make this function work
 */
exports.generateToken = functions.https.onCall(async (request, response) => {
    try {
        const channelName = request.channelName;
        if (!channelName) {
            throw new functions.https.HttpsError("invalid-argument", "channel is required.");
        }
        let uid = request.uid;
        if (!uid || uid == "") {
            uid = 0;
        }
        let role = RtcRole.SUBSCRIBER;
        if (request.role == "publisher") {
            role = RtcRole.PUBLISHER;
        }
        let expireTime = request.expireTime;
        if (!expireTime || expireTime == "") {
            expireTime = 3600;
        }
        else {
            expireTime = parseInt(expireTime, 10);
        }
        // calculate privilege expire time
        const currentTime = Math.floor(Date.now() / 1000);
        const privilegeExpireTime = currentTime + expireTime;
        const agoraAppId = process.env.AGORA_APP_ID;
        const agoraCertificate = process.env.AGORA_CERTIFICATE;
        const token = RtcTokenBuilder.buildTokenWithUid(agoraAppId, agoraCertificate, channelName, uid, role, privilegeExpireTime);
        console.log("token : " + token);
        console.log("room name : " + channelName);
        return token;
    }
    catch (e) {
        throw e;
    }
});
//# sourceMappingURL=agora-functions.js.map