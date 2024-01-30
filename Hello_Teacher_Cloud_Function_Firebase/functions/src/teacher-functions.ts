import * as functions from "firebase-functions";
import { DefaultBasePrice, DefaultTeacherAccountStatus } from "./constants";
import { deleteTeacher } from "./user-service";

/** delete teacher data function, this function will delete the teacher data, also with its user, if you only wanto delete the teacher data 
goto the user service
 */
export const deleteTeacherAccount = functions.https.onCall(
  async (request, response) => {
    try {
      console.log("delete teacher functions : " + request.teacherId);
      await deleteTeacher(request.teacherId);
    } catch (e) {
      throw e;
    }
  }
);
/** this function will detect the newly created teacher account and just change his balance to 0, we put it in cloud function
so they can't change their balance in client side for security reason*/
export const teacherAdded = functions.firestore
  .document("/Teachers/{teacherId}")
  .onCreate((snapshot, context) => {
    snapshot.ref.update({
      balance: 0,
      accountStatus: DefaultTeacherAccountStatus,
      basePrice: DefaultBasePrice,
    });
    return Promise.resolve();
  });
