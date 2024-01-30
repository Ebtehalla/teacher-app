import 'package:get/get.dart';

import '../controllers/teacher_register_controller.dart';

class TeacherRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherRegisterController>(
      () => TeacherRegisterController(),
    );
  }
}
