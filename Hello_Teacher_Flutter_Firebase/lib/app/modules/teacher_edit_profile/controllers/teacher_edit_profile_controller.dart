import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/modules/teacher_edit_profile/views/pages/change_password_page.dart';
import 'package:halo_teacher/app/modules/teacher_edit_profile/views/pages/update_email_page.dart';
import 'package:halo_teacher/app/modules/teacher_edit_profile/views/pages/change_base_price.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class TeacherEditProfileController extends GetxController {
  final username = UserService().currentUserFirebase!.displayName.obs;
  var email = UserService().currentUserFirebase!.email.obs;
  final password = '******';
  var newPassword = ''.obs;
  var basePrice = 0.obs;
  late TextEditingController textEditingBasePriceController;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Teacher? currentTeacher = await TeacherService.getCurrentTeacher();
    if (currentTeacher == null) {
      Fluttertoast.showToast(msg: 'Teacher data is null');
      printError(info: 'teacher data is null');
      return;
    }
    basePrice.value = currentTeacher.basePrice ?? 0;
    textEditingBasePriceController =
        TextEditingController(text: currentTeacher.basePrice.toString());
  }

  toUpdateEmail() => Get.to(() => UpdateEmailPage());
  toChangePassword() => Get.to(() => ChangePasswordPage());
  toChangeBasePrice() => Get.to(() => ChangeBasePrice());
  void updateEmail(String email) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updateEmail(email).then((value) {
      Get.back();
      this.email.value = email;
      update();
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void changePassword(String currentPassword, String newPassword) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    try {
      await UserService().changePassword(currentPassword, newPassword);
      currentPassword = '';
      newPassword = '';
      Get.back();
      Fluttertoast.showToast(msg: 'Successfully change password'.tr);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    EasyLoading.dismiss();
  }

  Future saveBasePrice() async {
    try {
      int newBasePrice = int.parse(textEditingBasePriceController.text);
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await TeacherService().updateTeacherBasePrice(newBasePrice);
      basePrice.value = newBasePrice;
      update();
      Get.back();
    } catch (e) {
      return Future.error(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void toDeleteAccount() {
    Get.toNamed(Routes.TEACHER_DELETE_ACCOUNT);
  }
}
