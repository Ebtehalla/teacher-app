import 'package:get/get.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(AuthService());
    Get.put(UserService());
  }
}
