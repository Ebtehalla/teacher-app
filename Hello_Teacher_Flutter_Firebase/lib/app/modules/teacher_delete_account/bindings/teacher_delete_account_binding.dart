import 'package:get/get.dart';

import '../controllers/teacher_delete_account_controller.dart';

class TeacherDeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDeleteAccountController>(
      () => TeacherDeleteAccountController(),
    );
  }
}
