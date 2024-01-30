import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/login/controllers/login_controller.dart';
import 'package:halo_teacher/app/services/auth_service.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put(AuthService());
  }
}
