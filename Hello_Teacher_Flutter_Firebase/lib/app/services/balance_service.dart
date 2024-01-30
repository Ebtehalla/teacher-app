import 'package:firebase_auth/firebase_auth.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

class BalanceService {
  Future<int> getBalance() async {
    try {
      var teacher = await TeacherService.getCurrentTeacher();
      var teacherFirebase =
          await FirebaseCollection().teacherCol.doc(teacher?.id).get();
      int teacherBalance = teacherFirebase.data()?.balance ?? 0;
      return teacherBalance;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
