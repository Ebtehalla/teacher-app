import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/modules/login/controllers/login_controller.dart';
import 'package:halo_teacher/app/services/auth_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  LoginController loginController = Get.find();
  AuthService authService = Get.find();
  final count = 0.obs;
  var formkey = GlobalKey<FormState>();
  var username = '';
  var email = '';
  var password = '';
  var passwordVisible = false;

  @override
  void onClose() {}

  void increment() => count.value++;

  void signUpUser() async {
    try {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        EasyLoading.show(
            status: 'loading...', maskType: EasyLoadingMaskType.black);
        await authService.register(username, email, password, Roles.user);
        Get.offAllNamed('/dashboard');
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
}
