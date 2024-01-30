"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.doctorAdded = exports.deleteDoctorAccount = void 0;
const functions = require("firebase-functions");
const constants_1 = require("./constants");
const user_service_1 = require("./user-service");
/** delete doctor data function, this function will delete the doctor data, also with its user, if you only wanto delete the doctor data
goto the user service
 */
exports.deleteDoctorAccount = functions.https.onCall(async (request, response) => {
    try {
        console.log("delete doctor functions : " + request.doctorId);
        await (0, user_service_1.deleteDoctor)(request.doctorId);
    }
    catch (e) {
        throw e;
    }
});
/** this function will detect the newly created doctor account and just change his balance to 0, we put it in cloud function
so they can't change their balance in client side for security reason*/
exports.doctorAdded = functions.firestore
    .document("/Teachers/{teacherId}")
    .onCreate((snapshot, context) => {
    snapshot.ref.update({
        balance: 0,
        accountStatus: constants_1.DefaultDoctorAccountStatus,
        doctorBasePrice: constants_1.DoctorDefaultBasePrice,
    });
    return Promise.resolve();
});
//# sourceMappingURL=doctor-functions.js.map