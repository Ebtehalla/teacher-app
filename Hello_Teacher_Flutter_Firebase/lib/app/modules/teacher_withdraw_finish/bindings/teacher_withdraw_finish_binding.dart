import 'package:get/get.dart';

import '../controllers/teacher_withdraw_finish_controller.dart';

class TeacherWithdrawFinishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherWithdrawFinishController>(
      () => TeacherWithdrawFinishController(),
    );
  }
}
