import 'package:get/get.dart';

import '../controllers/teacher_login_controller.dart';

class TeacherLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherLoginController>(
      () => TeacherLoginController(),
    );
  }
}
