import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/routes/app_pages.dart';
import 'package:hello_teacher_admin_dashboard/app/services/auth_service.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormBuilderState>();
  void login() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    try {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        var username = loginFormKey.currentState!.value['email'];
        var password = loginFormKey.currentState!.value['password'];

        await AuthService().login(username, password);
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
