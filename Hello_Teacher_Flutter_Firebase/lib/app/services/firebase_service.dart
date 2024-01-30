import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';
import 'package:halo_teacher/app/utils/utils.dart';
import 'package:path/path.dart';

class FirebaseService {
  Future<bool> checkUserAlreadyLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      printInfo(info: 'User Uid : ${auth.currentUser!.uid}');
      return true;
    } else {
      printInfo(info: 'User not login yet');
      return false;
    }
  }

  Future userSetup(User user, String displayName, Roles userRole) async {
    String uid = user.uid.toString();
    UserModel newUser = UserModel(
        email: user.email,
        displayName: displayName,
        photoUrl: user.photoURL,
        lastLogin: user.metadata.lastSignInTime,
        createdAt: user.metadata.creationTime,
        role: userRole);

    await FirebaseCollection()
        .userCol
        .doc(uid)
        .set(newUser, SetOptions(merge: true));
  }

  Future userTeacherSetup(User user, String displayName, Roles userRole) async {
    try {
      String uid = user.uid.toString();
      String teacherId = uid;
      UserModel newUserTeacher = UserModel(
          email: user.email,
          displayName: displayName,
          photoUrl: user.photoURL,
          lastLogin: user.metadata.lastSignInTime,
          createdAt: user.metadata.creationTime,
          teacherId: teacherId,
          role: userRole);

      await FirebaseCollection()
          .userCol
          .doc(uid)
          .set(newUserTeacher, SetOptions(merge: true));

      await teacherSetup(teacherId, user, displayName, userRole);
    } catch (e) {
      return Future.error(e);
    }
  }

  ///add new teacher
  Future teacherSetup(
      String teacherId, User user, String displayName, Roles userRole) async {
    String uid = user.uid.toString();
    Teacher newTeacher = Teacher(
        id: teacherId,
        email: user.email,
        name: displayName,
        createdAt: user.metadata.creationTime,
        updatedAt: user.metadata.creationTime,
        userId: uid);

    await FirebaseCollection().teacherCol.doc(teacherId).set(newTeacher);
    TeacherService.setCurrentTeacher(newTeacher);
  }

  Future<String> uploadImage(File filePath) async {
    try {
      String fileName = basename(filePath.path);
      var ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      final result = await ref.putFile(File(filePath.path));
      final fileUrl = await result.ref.getDownloadURL();
      return fileUrl;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
