import 'package:get/get.dart';
import 'package:halo_teacher/app/services/user_service.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.put(UserService());
  }
}
