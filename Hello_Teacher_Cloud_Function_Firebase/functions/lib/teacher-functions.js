"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.teacherAdded = exports.deleteTeacherAccount = void 0;
const functions = require("firebase-functions");
const constants_1 = require("./constants");
const user_service_1 = require("./user-service");
/** delete teacher data function, this function will delete the teacher data, also with its user, if you only wanto delete the teacher data
goto the user service
 */
exports.deleteTeacherAccount = functions.https.onCall(async (request, response) => {
    try {
        console.log("delete teacher functions : " + request.teacherId);
        await (0, user_service_1.deleteTeacher)(request.teacherId);
    }
    catch (e) {
        throw e;
    }
});
/** this function will detect the newly created teacher account and just change his balance to 0, we put it in cloud function
so they can't change their balance in client side for security reason*/
exports.teacherAdded = functions.firestore
    .document("/Teachers/{teacherId}")
    .onCreate((snapshot, context) => {
    snapshot.ref.update({
        balance: 0,
        accountStatus: constants_1.DefaultTeacherAccountStatus,
        basePrice: constants_1.DefaultBasePrice,
    });
    return Promise.resolve();
});
//# sourceMappingURL=teacher-functions.js.map