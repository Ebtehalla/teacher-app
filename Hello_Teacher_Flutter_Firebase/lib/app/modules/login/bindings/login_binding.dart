import 'package:get/get.dart';
import 'package:halo_teacher/app/services/auth_service.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put(AuthService());
  }
}
