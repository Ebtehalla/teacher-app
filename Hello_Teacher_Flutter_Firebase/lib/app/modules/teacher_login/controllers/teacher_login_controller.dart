import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';

class TeacherLoginController extends GetxController {
  var loginFormKey = GlobalKey<FormState>();
  var username = '';
  var password = '';
  bool passwordVisible = true;
  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  Future login() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        await AuthService().login(username, password);
        final teacherDetail = await AuthService().checkTeacherDetail();
        if (teacherDetail) {
          GetStorage().write(checkTeacherDetail, teacherDetail);
        }
        Get.offNamed(Routes.TEACHER_DASHBOARD);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      return Future.error(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
