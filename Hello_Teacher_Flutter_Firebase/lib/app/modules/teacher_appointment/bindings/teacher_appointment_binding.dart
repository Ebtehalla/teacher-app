import 'package:get/get.dart';

import '../controllers/teacher_appointment_controller.dart';

class TeacherAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherAppointmentController>(
      () => TeacherAppointmentController(),
    );
  }
}
