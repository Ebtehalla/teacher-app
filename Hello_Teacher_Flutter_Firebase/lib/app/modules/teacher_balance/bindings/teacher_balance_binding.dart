import 'package:get/get.dart';

import '../controllers/teacher_balance_controller.dart';

class TeacherBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherBalanceController>(
      () => TeacherBalanceController(),
    );
  }
}
