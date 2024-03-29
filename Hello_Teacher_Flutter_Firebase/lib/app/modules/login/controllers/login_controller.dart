import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/services/auth_service.dart';

class LoginController extends GetxController {
  AuthService authService = Get.find();
  var loginFormKey = GlobalKey<FormBuilderState>();
  final count = 0.obs;
  bool passwordVisible = false;
  @override
  void onInit() {
    super.onInit();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  void loginGoogle() {
    authService
        .loginGoogle(Roles.user)
        .then((value) => Get.offAllNamed('/dashboard'));
  }

  void loginApple() {
    authService
        .signInWithApple(Roles.user)
        .then((value) => Get.offAllNamed('/dashboard'));
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      var username = loginFormKey.currentState!.value['username'];
      var password = loginFormKey.currentState!.value['password'];
      EasyLoading.show();

      authService.login(username, password).then((value) {
        Get.offAllNamed('/dashboard');
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }
}
