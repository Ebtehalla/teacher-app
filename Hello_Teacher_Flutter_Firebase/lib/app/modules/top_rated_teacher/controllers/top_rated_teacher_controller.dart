import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

class TopRatedTeacherController extends GetxController
    with StateMixin<List<Teacher>> {
  @override
  void onInit() {
    super.onInit();
    TeacherService().getTopRatedTeacher().then((value) {
      change(value, status: RxStatus.success());
    });
  }
}
