import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/chat_service.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class TeacherProfileController extends GetxController {
  var user = UserService().currentUserFirebase;
  bool tap = false;
  var photoUrl = ''.obs;
  var displayName = ''.obs;
  String? accountStatus = '';
  bool isAccountActivated = false;

  @override
  void onReady() async {
    super.onReady();
    photoUrl.value = UserService().getProfilePicture();
    Teacher? doc = await TeacherService.getCurrentTeacher();
    accountStatus = doc?.accountStatus;
    displayName.value = doc?.name ?? '';
    if (accountStatus == 'active') {
      isAccountActivated = true;
    }
    update();
  }

  void toEditProfile() {
    Get.toNamed(Routes.TEACHER_EDIT_PROFILE);
  }

  void toBalance() {
    Get.toNamed(Routes.TEACHER_BALANCE);
  }

  void toEditTeacherDetail() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var teacher = await TeacherService.getCurrentTeacher();
    EasyLoading.dismiss();
    Get.toNamed(Routes.ADD_TEACHER_DETAIL, arguments: teacher);
  }

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        AuthService().logout();
        Get.offAllNamed(Routes.TEACHER_LOGIN);
      },
    );
  }

  /// this is just for test, you can remove it
  void test() async {
    var roomData = await ChatService().getRoomById('04lHxDfpu8shsGDHDDOB');
    print('data : ' + roomData.toString());
    // //await ChatService().getListChat();
    // NotificationService().testNotification();
  }
}
