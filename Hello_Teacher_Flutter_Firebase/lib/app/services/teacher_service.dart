import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/category_model.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/services/user_service.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';

class TeacherService {
  static Teacher? _currentTeacher;

  /// Set the teacher data for the current teacher
  static void setCurrentTeacher(Teacher? teacher) {
    _currentTeacher = teacher;
  }

  /// Get the teacher data for the current teacher. If currentTeacher is null,
  /// fetch the data from Firestore.
  /// current teacher cannot be null, if it null probably the user not set set their teacher detail yet
  /// or, the user is not teacher, and try to acces current teacher which they don't have
  static Future<Teacher?> getCurrentTeacher({bool forceGet = false}) async {
    if (forceGet) {
      Teacher? teacher = await getTeacherFromFirestore();
      _currentTeacher = teacher;
      return teacher;
    }
    if (_currentTeacher == null) {
      Teacher? teacher = await getTeacherFromFirestore();
      _currentTeacher = teacher;
      return teacher;
    } else {
      return _currentTeacher;
    }
  }

  static Future<Teacher?> getTeacherFromFirestore() async {
    try {
      final teacherId = await UserService().getTeacherId();
      if (teacherId != null) {
        var teacherRef =
            await FirebaseCollection().teacherCol.doc(teacherId).get();
        if (teacherRef.data() != null) {
          _currentTeacher = teacherRef.data();
          return teacherRef.data()!;
        } else {
          return null;
        }
      } else {
        throw Exception('teacher id is null in this current user');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future saveTeacherData(
      {required String teacherName,
      required String education,
      required String shortBiography,
      required String pictureUrl,
      required CategoryModel teacherCategory,
      bool isUpdate = false}) async {
    try {
      Teacher? currentTeacher = await getCurrentTeacher();
      if (currentTeacher == null) throw Exception('current teacher is null');
      Teacher newUpdatedTeacher = Teacher(
          id: currentTeacher.id,
          picture: pictureUrl,
          name: teacherName,
          education: education,
          shortBiography: shortBiography,
          category: teacherCategory);
      if (isUpdate) {
        newUpdatedTeacher.updatedAt = DateTime.now();
        var toJson = newUpdatedTeacher.toJson();
        await FirebaseCollection()
            .teacherCol
            .doc(currentTeacher.id)
            .update(newUpdatedTeacher.toJson());
        _currentTeacher = newUpdatedTeacher;
      } else {
        newUpdatedTeacher.basePrice = defaultTeacherBasePrice;
        newUpdatedTeacher.createdAt = DateTime.now();
        newUpdatedTeacher.updatedAt = DateTime.now();
        var toJson = newUpdatedTeacher.toJson();
        print('to json : ' + toJson.toString());
        await FirebaseCollection()
            .teacherCol
            .doc(currentTeacher.id)
            .set(newUpdatedTeacher, SetOptions(merge: true));
        _currentTeacher = newUpdatedTeacher;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Teacher?> getTeacherById(String teacherId) async {
    try {
      var teacherRef =
          await FirebaseCollection().teacherCol.doc(teacherId).get();
      if (teacherRef.exists) {
        var teacher = teacherRef.data();
        _currentTeacher = teacher;
        return teacher;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Get list of Teacher schedule base on teacher id
  Future<List<TimeSlot>> getTeacherTimeSlot(Teacher teacher) async {
    try {
      var timeslotRef = await FirebaseCollection()
          .timeSlotCol
          .where('teacherId', isEqualTo: teacher.id)
          .get();
      List<TimeSlot> listTimeslot =
          timeslotRef.docs.map((doc) => doc.data()).toList();
      if (timeslotRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// Get teacher and all its property
  Future<Teacher> getTeacherDetail(String teacherId) async {
    var teacher = await FirebaseCollection().teacherCol.doc(teacherId).get();
    if (teacher.exists) {
      return teacher.data()!;
    } else {
      throw Exception('Teacerh data is not found');
    }
  }

  Future<List<Teacher>> getListTeacherByCategory(CategoryModel category) async {
    try {
      var listTeacherRef = await FirebaseCollection()
          .teacherCol
          .where('category.categoryId', isEqualTo: category.categoryId)
          .where('accountStatus', isEqualTo: 'active')
          .get();
      if (listTeacherRef.docs.isEmpty) return [];
      var listTeacher = listTeacherRef.docs.map((doc) => doc.data()).toList();
      return listTeacher;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Teacher>> getTopRatedTeacher({int limit = 10}) async {
    try {
      // var topRatedTeacher =
      //     await FirebaseCollection().topRatedTeacherCol.limit(limit).get();
      // List<String> listIdTopRatedTeacher = topRatedTeacher.docs.map((doc) {
      //   if (doc.data().teacherId == null) return '';
      //   String myList = doc.data().teacherId!.replaceAll(RegExp(r"\s+"), "");
      //   return myList;
      // }).toList();

      // if (listIdTopRatedTeacher.isEmpty) return [];
      var teacherRef = await FirebaseCollection()
          .teacherCol
          .where('topRated', isEqualTo: true)
          .get();

      List<Teacher> listTopTeacher =
          teacherRef.docs.map((doc) => doc.data()).toList();
      if (listTopTeacher.isEmpty) return [];
      return listTopTeacher;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Teacher>> searchTeacher(String teacherName) async {
    try {
      if (teacherName.isEmpty) return [];
      var teacherRef = await FirebaseCollection()
          .teacherCol
          .where('name',
              isGreaterThanOrEqualTo: teacherName,
              isLessThan: teacherName.substring(0, teacherName.length - 1) +
                  String.fromCharCode(
                      teacherName.codeUnitAt(teacherName.length - 1) + 1))
          .get();
      List<Teacher> listTeacher =
          teacherRef.docs.map((doc) => doc.data()).toList();
      listTeacher.removeWhere((element) => element.accountStatus != 'active');
      print('data searchnya : ' + listTeacher.toString());
      return listTeacher;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> getUserId(Teacher teacher) async {
    try {
      var user = await FirebaseCollection()
          .userCol
          .where('teacherId', isEqualTo: teacher.id)
          .get();
      if (user.docs.isEmpty) return '';
      return user.docs.elementAt(0).id;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateTeacherBasePrice(int basePrice) async {
    try {
      await FirebaseCollection()
          .teacherCol
          .doc(_currentTeacher?.id)
          .update({'basePrice': basePrice});
      _currentTeacher?.basePrice = basePrice;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
