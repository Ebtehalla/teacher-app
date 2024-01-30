import 'package:get/get.dart';

import '../controllers/teacher_edit_profile_controller.dart';

class TeacherEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeacherEditProfileController());
  }
}
