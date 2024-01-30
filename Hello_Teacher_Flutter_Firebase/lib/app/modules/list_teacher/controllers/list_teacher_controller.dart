import 'package:get/get.dart';
import 'package:halo_teacher/app/models/category_model.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

class ListTeacherController extends GetxController
    with StateMixin<List<Teacher>> {
  CategoryModel category = Get.arguments;
  List<Teacher> listTeacher = [];
  @override
  void onInit() async {
    super.onInit();
    try {
      listTeacher = await TeacherService().getListTeacherByCategory(category);
      if (listTeacher.isEmpty) return change([], status: RxStatus.empty());
      change(listTeacher, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }
}
