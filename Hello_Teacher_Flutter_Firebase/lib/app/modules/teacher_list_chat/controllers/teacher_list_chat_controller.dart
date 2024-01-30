import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

class TeacherListChatController extends GetxController {
  Teacher? currentTeacher;

  @override
  void onInit() async {
    super.onInit();
    currentTeacher = await TeacherService.getCurrentTeacher();
  }
}
