import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/home/controllers/home_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/users/controllers/users_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(UsersController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
