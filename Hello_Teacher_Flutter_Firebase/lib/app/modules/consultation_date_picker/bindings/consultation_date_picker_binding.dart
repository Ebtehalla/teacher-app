import 'package:get/get.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

import '../controllers/consultation_date_picker_controller.dart';

class ConsultationDatePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultationDatePickerController>(
      () => ConsultationDatePickerController(),
    );
    Get.lazyPut<TeacherService>(() => TeacherService());
  }
}
