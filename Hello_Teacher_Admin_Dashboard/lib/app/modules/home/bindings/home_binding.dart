import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/services/auth_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(DashboardController());
    Get.put(AuthService());
  }
}
