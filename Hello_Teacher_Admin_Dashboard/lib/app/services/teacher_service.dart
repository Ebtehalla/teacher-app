import 'package:hello_teacher_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_teacher_admin_dashboard/app/models/teacher_model.dart';
import 'package:hello_teacher_admin_dashboard/app/models/top_rated_teacher_model.dart';

class TeacherService {
  Future<List<TeacherModel>> getTeacher() async {
    try {
      var listTeacherRef = await FirebaseCollection().teacherCol.get();
      if (listTeacherRef.docs.isEmpty) return [];
      List<TeacherModel> listTeacher =
          listTeacherRef.docs.map((doc) => doc.data()).toList();
      return listTeacher;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future activateTeacher(String teacherId) async {
    try {
      await FirebaseCollection()
          .teacherCol
          .doc(teacherId)
          .update({'accountStatus': 'active'});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future bannedTeacher(String teacherId) async {
    try {
      await FirebaseCollection()
          .teacherCol
          .doc(teacherId)
          .update({'accountStatus': 'nonactive'});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getTopRatedTeachers() async {
    try {
      var teachersRef = await FirebaseCollection()
          .teacherCol
          .where('topRated', isEqualTo: true)
          .get();
      var listTopRatedTeacher =
          teachersRef.docs.map((doc) => doc.data()).toList();
      return listTopRatedTeacher;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addTopRatedTeacher(String teacherId) async {
    try {
      var newTopRatedTeacher = TopRatedTeacher(teacherId: teacherId);
      await FirebaseCollection()
          .topRatedTeacherCol
          .doc(teacherId)
          .set(newTopRatedTeacher);
      await FirebaseCollection()
          .teacherCol
          .doc(teacherId)
          .update({'topRated': true});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future removeTopRatedTeacher(String teacherId) async {
    try {
      await FirebaseCollection().topRatedTeacherCol.doc(teacherId).delete();
      await FirebaseCollection()
          .teacherCol
          .doc(teacherId)
          .update({'topRated': false});
    } catch (e) {
      return Future.error(e);
    }
  }
}
