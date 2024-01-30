import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:halo_teacher/app/modules/category/controllers/category_controller.dart';
import 'package:halo_teacher/app/modules/home/controllers/home_controller.dart';
import 'package:halo_teacher/app/modules/profile/controllers/profile_controller.dart';
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:halo_teacher/app/services/timeslot_service.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationService>(
      () => NotificationService(),
    );
    Get.put(
      DashboardController(),
    );
    Get.put(AuthService());
    Get.lazyPut<UserService>(() => UserService());
    Get.put(HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<TimeSlotService>(() => TimeSlotService());
  }
}
