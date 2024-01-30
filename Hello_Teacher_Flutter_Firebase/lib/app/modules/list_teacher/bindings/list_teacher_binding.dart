import 'package:get/get.dart';

import '../controllers/list_teacher_controller.dart';

class ListTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTeacherController>(
      () => ListTeacherController(),
    );
  }
}
