import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/profile/controllers/profile_controller.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

import '../controllers/add_teacher_detail_controller.dart';

class AddTeacherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTeacherDetailController>(
      () => AddTeacherDetailController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<AuthService>(
      () => AuthService(),
    );
    Get.lazyPut(() => UserService());
  }
}
