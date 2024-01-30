import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/models/teacher_model.dart';
import 'package:hello_teacher_admin_dashboard/app/models/teacher_table_source.dart';
import 'package:hello_teacher_admin_dashboard/app/services/teacher_service.dart';

class TeachersController extends GetxController
    with StateMixin<List<TeacherModel>> {
  List<TeacherModel>? listTeacher;
  late TeacherTableSource teacherTableSource;
  String searchQuery = '';
  late List<TeacherModel> filteredList = [];
  TextEditingController searchController = TextEditingController();
  TeacherModel? selectedTeacher;
  @override
  void onInit() {
    super.onInit();
  }

  Future initTeachersTab() async {
    try {
      if (listTeacher == null) {
        listTeacher = await TeacherService().getTeacher();
        teacherTableSource = TeacherTableSource(listTeacher!);
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

  void activateTeacher(String teacherId) async {
    EasyLoading.show();
    try {
      await TeacherService().activateTeacher(teacherId);
      TeacherModel teacherActivated =
          listTeacher!.firstWhere((element) => element.id == teacherId);
      teacherActivated.accountStatus = 'active';
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void dissableTeacher(String teacherId) async {
    EasyLoading.show();
    try {
      await TeacherService().bannedTeacher(teacherId);
      TeacherModel teacherActivated =
          listTeacher!.firstWhere((element) => element.id == teacherId);
      teacherActivated.accountStatus = 'nonactive';
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future addToTopRatedTeacher(String teacherId) async {
    try {
      await TeacherService().addTopRatedTeacher(teacherId);
      TeacherModel teacherTopRated =
          listTeacher!.firstWhere((element) => element.id == teacherId);
      teacherTopRated.topRated = true;
      teacherTableSource = TeacherTableSource(listTeacher!);
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future removeTeacherFromTopRated(String teacherId) async {
    try {
      await TeacherService().removeTopRatedTeacher(teacherId);
      TeacherModel teacherTopRated =
          listTeacher!.firstWhere((element) => element.id == teacherId);
      teacherTopRated.topRated = false;
      teacherTableSource = TeacherTableSource(listTeacher!);
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  void searchteachers(String query) {
    filteredList = listTeacher!.where((teacher) {
      final name = teacher.name?.toLowerCase();
      if (name != null) {
        return name.contains(query.toLowerCase());
      } else {
        return false;
      }
    }).toList();
    change(listTeacher, status: RxStatus.success());
    teacherTableSource =
        TeacherTableSource(filteredList); // Update teacherTableSource
    update(); // Notify listeners that the filtered list has changed
  }
}
