import 'package:get/get.dart';

import '../controllers/detail_teacher_controller.dart';

class DetailTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTeacherController>(
      () => DetailTeacherController(),
    );
  }
}
