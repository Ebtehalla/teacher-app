import 'package:get/get.dart';

import '../controllers/search_teacher_controller.dart';

class SearchTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchTeacherController>(
      () => SearchTeacherController(),
    );
  }
}
