import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/models/teacher_model.dart';
import 'package:hello_teacher_admin_dashboard/app/models/top_rated_teacher_model.dart';
import 'package:hello_teacher_admin_dashboard/app/services/teacher_service.dart';

class TopRatedTeacherController extends GetxController
    with StateMixin<List<TeacherModel>> {
  //TODO: Implement TopRatedTeacherController

  final count = 0.obs;
  List<TeacherModel> listTeacher = [];
  @override
  void onInit() {
    super.onInit();
  }

  Future initTopRatedTeacherTab() async {
    try {
      if (listTeacher == null || listTeacher.isEmpty) {
        listTeacher = await TeacherService().getTopRatedTeachers();
        change(listTeacher, status: RxStatus.success());
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future addToTopRatedTeacher(String teacherId) async {
    try {
      await TeacherService().addTopRatedTeacher(teacherId);
      TeacherModel teacherTopRated =
          listTeacher.firstWhere((element) => element.id == teacherId);
      teacherTopRated.topRated = true;
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future removeTeacherFromTopRated(String teacherId) async {
    try {
      await TeacherService().removeTopRatedTeacher(teacherId);
      TeacherModel teacherTopRated =
          listTeacher.firstWhere((element) => element.id == teacherId);
      teacherTopRated.topRated = false;
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }
}
