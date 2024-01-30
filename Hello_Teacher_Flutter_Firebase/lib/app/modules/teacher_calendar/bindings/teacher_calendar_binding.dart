import 'package:get/get.dart';

import '../controllers/teacher_calendar_controller.dart';

class TeacherCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherCalendarController>(
      () => TeacherCalendarController(),
    );
  }
}
