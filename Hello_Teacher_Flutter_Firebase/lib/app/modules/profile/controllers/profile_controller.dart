import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/chat/views/list_users_view.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/local_notification_service.dart';
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:halo_teacher/app/modules/profile/views/pages/change_password.dart';
import 'package:halo_teacher/app/modules/profile/views/pages/edit_image_page.dart';
import 'package:halo_teacher/app/modules/profile/views/pages/update_email_page.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var username = ''.obs;
  var profilePic = ''.obs;
  var appVersion = ''.obs;
  var email = ''.obs;
  var newPassword = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    var userModel = await UserService().getUserModel();
    profilePic.value = userService.getProfilePicture();
    username.value = userModel?.displayName ?? '';
    email.value = userModel?.email ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        authService.logout().then(
              (value) => Get.offAllNamed(Routes.TEACHER_LOGIN),
            );
      },
    );
  }

  toEditImage() {
    Get.to(() => EditImagePage());
  }

  toUpdateEmail() {
    Get.to(() => UpdateEmailPage());
  }

  toChangePassword() {
    Get.to(() => ChangePasswordPage());
  }

  void updateEmail(String email) async {
    // if (!(await checkGoogleLogin())) return;
    try {
      EasyLoading.show();
      UserService().updateEmail(email).then((value) {
        Get.back();
        this.email.value = email;
        update();
      }).catchError((err) {
        Fluttertoast.showToast(msg: err.toString());
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    userService.updateProfilePic(filePath).then((updatedUrl) {
      profilePic.value = updatedUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void changePassword(String currentPassword, String newPassword) async {
    // if (!(await checkGoogleLogin())) return;

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

//user for testing something
  Future testButton() async {
    try {
      DateTime scheduleTime = DateTime.now();
      final oneMinutefromNow = scheduleTime.add(const Duration(seconds: 20));
      debugPrint('Notification Scheduled for $oneMinutefromNow');
      LocalNotificationService().scheduleNotification(
          title: 'Scheduled Notification',
          body: '$oneMinutefromNow',
          scheduledNotificationDateTime: oneMinutefromNow);
      //NotificationService().testNotification();
      // DateTime now = DateTime.now();
      // Duration tenMinutes = Duration(minutes: 10);
      // DateTime tenMinutesBefore = now.subtract(tenMinutes);

      // print(
      //     'Ten minutes before ${now.toString()}: ${tenMinutesBefore.toString()}');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void toSettings() {
    Get.toNamed(Routes.SETTINGS);
  }
}
