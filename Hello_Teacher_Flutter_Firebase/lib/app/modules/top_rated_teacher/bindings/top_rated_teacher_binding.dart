import 'package:get/get.dart';

import '../controllers/top_rated_teacher_controller.dart';

class TopRatedTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedTeacherController>(
      () => TopRatedTeacherController(),
    );
  }
}
