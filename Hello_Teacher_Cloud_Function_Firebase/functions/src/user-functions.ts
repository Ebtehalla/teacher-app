import * as functions from "firebase-functions";
import { deleteUser } from "./user-service";
import { Role } from "./collections";

/** function to Delete user account permanently, this function is called in admin dashboard */
export const deleteUserPermanently = functions.https.onCall(
  async (request, context) => {
    try {
      console.log("delete user functions, user id : " + request.userId);
      await deleteUser(request.userId);
    } catch (e) {
      throw new Error("error deleting user");
    }
  }
);
/**
 * Check newly user added if the role is teacher, add the teacher id to user data,
 * we put it on cloud function just for security reson, so that new teacher can't assing another teacher id to the user
 */
export const userAdded = functions.firestore
  .document("/Users/{userId}")
  .onCreate((snapshot, context) => {
    if (snapshot.data().role == Role.Teacher) {
      snapshot.ref.update({ teacherId: snapshot.id });
    }
    return Promise.resolve();
  });
