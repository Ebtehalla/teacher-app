import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/add_timeslot/controllers/add_timeslot_controller.dart';
import 'package:halo_teacher/app/modules/teacher_calendar/controllers/teacher_calendar_controller.dart';

class AddTimeslotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTimeslotController>(
      () => AddTimeslotController(),
    );
    Get.lazyPut<TeacherCalendarController>(
      () => TeacherCalendarController(),
    );
  }
}
