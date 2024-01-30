"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userAdded = exports.deleteUserPermanently = void 0;
const functions = require("firebase-functions");
const user_service_1 = require("./user-service");
const collections_1 = require("./collections");
/** function to Delete user account permanently, this function is called in admin dashboard */
exports.deleteUserPermanently = functions.https.onCall(async (request, context) => {
    try {
        console.log("delete user functions, user id : " + request.userId);
        await (0, user_service_1.deleteUser)(request.userId);
    }
    catch (e) {
        throw new Error("error deleting user");
    }
});
/**
 * Check newly user added if the role is teacher, add the teacher id to user data,
 * we put it on cloud function just for security reson, so that new teacher can't assing another teacher id to the user
 */
exports.userAdded = functions.firestore
    .document("/Users/{userId}")
    .onCreate((snapshot, context) => {
    if (snapshot.data().role == collections_1.Role.Teacher) {
        snapshot.ref.update({ teacherId: snapshot.id });
    }
    return Promise.resolve();
});
//# sourceMappingURL=user-functions.js.map