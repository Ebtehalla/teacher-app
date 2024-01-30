import 'package:get/get.dart';

import '../controllers/teacher_detail_order_controller.dart';

class TeacherDetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDetailOrderController>(
      () => TeacherDetailOrderController(),
    );
  }
}
