import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/auth_service.dart';

class TeacherRegisterController extends GetxController {
  var formkey = GlobalKey<FormBuilderState>();
  var username = '';
  var email = '';
  var password = '';
  var passwordVisible = false;
  void signUpUser() async {
    try {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        EasyLoading.show(
            status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
        await AuthService().register(username, email, password, Roles.teacher);
        Get.offAllNamed(Routes.ADD_TEACHER_DETAIL);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }
}
