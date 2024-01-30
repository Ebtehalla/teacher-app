import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/services/auth_service.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
