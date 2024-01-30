import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/teacher_appointment/controllers/teacher_appointment_controller.dart';
import 'package:halo_teacher/app/modules/teacher_calendar/controllers/teacher_calendar_controller.dart';
import 'package:halo_teacher/app/modules/teacher_home/controllers/teacher_home_controller.dart';
import 'package:halo_teacher/app/modules/teacher_list_chat/controllers/teacher_list_chat_controller.dart';
import 'package:halo_teacher/app/modules/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:halo_teacher/app/services/notification_service.dart';

import '../controllers/teacher_dashboard_controller.dart';

class TeacherDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDashboardController>(
      () => TeacherDashboardController(),
    );
    Get.lazyPut<NotificationService>(
      () => NotificationService(),
    );
    Get.lazyPut<TeacherHomeController>(
      () => TeacherHomeController(),
    );
    Get.lazyPut<TeacherCalendarController>(
      () => TeacherCalendarController(),
    );
    Get.lazyPut<TeacherAppointmentController>(
      () => TeacherAppointmentController(),
    );
    Get.lazyPut<TeacherProfileController>(
      () => TeacherProfileController(),
    );
    Get.put(TeacherListChatController());
  }
}
