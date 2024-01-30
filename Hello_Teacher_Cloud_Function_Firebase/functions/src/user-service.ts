import { usersCol, UserModel, teacherCol } from "./collections";
import * as admin from "firebase-admin";
export async function getUserTokenById(
  userId: string
): Promise<string | string[]> {
  let user = await usersCol.doc(userId).get();
  return Promise.resolve(user.data()?.token!);
}
/** Get user by providing teacher id */
export async function getUserByTeacherId(
  teacherId: string
): Promise<UserModel> {
  var userRef = await usersCol.where("teacherId", "==", teacherId).get();
  return userRef.docs[0].data();
}

async function deleteUserInDb(userId: string) {
  try {
    await usersCol.doc(userId).delete();
    console.log("success delete user in Db");
  } catch (error) {
    console.log("fail delete user in auth");
  }
}

async function deleteUserInAuth(userId: string) {
  try {
    await admin.auth().deleteUser(userId);

    console.log("success delete user in auth");
  } catch (error) {
    console.log("error delete user");
  }
}

export async function deleteTeacher(teacherId: string) {
  try {
    let user = await getUserByTeacherId(teacherId);
    await teacherCol.doc(teacherId).delete();
    if (user) {
      await deleteUser(user.uid);
      console.log("success delete user");
    } else {
      console.log("User null " + user);
    }

    console.log("success delete teacher");
  } catch (error) {
    console.log(
      "🚀 ~ file: user-service.js ~ line 67 ~ deleteTeacher ~ error",
      error
    );
    throw error;
  }
}

export async function deleteUser(userId: string) {
  try {
    await deleteUserInAuth(userId);
    await deleteUserInDb(userId);
  } catch (error) {
    console.log("failed delete user");
    throw error;
  }
}
