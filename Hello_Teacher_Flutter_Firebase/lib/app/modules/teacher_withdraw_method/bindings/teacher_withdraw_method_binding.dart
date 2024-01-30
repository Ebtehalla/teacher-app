import 'package:get/get.dart';

import '../controllers/teacher_withdraw_method_controller.dart';

class TeacherWithdrawMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherWithdrawMethodController>(
      () => TeacherWithdrawMethodController(),
    );
  }
}
