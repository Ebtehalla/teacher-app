import 'package:get/get.dart';

import '../controllers/teacher_withdraw_detail_controller.dart';

class TeacherWithdrawDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherWithdrawDetailController>(
      () => TeacherWithdrawDetailController(),
    );
  }
}
