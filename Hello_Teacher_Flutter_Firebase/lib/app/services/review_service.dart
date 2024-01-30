import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/review_model.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class ReviewService {
  Future saveReview(
      String review, int rating, TimeSlot timeSlot, User user) async {
    try {
      UserModel userModel = UserModel(
          userId: UserService().currentUserFirebase!.uid,
          displayName: UserService().currentUserFirebase!.displayName,
          photoUrl: UserService().getProfilePicture());
      ReviewModel reviewData = ReviewModel(
          review: review,
          rating: rating,
          timeSlotId: timeSlot.id,
          userId: UserService().currentUserFirebase!.uid,
          teacherId: timeSlot.teacherId,
          user: userModel);
      await FirebaseCollection().reviewCol.doc(timeSlot.id).set(reviewData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ReviewModel>> getTeacherReview(
      {required Teacher teacher, int limit = 4}) async {
    try {
      var reviewRef = await FirebaseCollection()
          .reviewCol
          .where('teacherId', isEqualTo: teacher.id)
          .limit(limit)
          .get();
      List<ReviewModel> listReview =
          reviewRef.docs.map((e) => e.data()).toList();
      return listReview;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
