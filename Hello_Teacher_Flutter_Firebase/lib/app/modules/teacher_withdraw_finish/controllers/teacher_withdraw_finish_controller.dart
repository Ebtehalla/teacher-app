import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/teacher_balance/controllers/teacher_balance_controller.dart';

class TeacherWithdrawFinishController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animController;
  @override
  void onInit() {
    super.onInit();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  ok() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      TeacherBalanceController balanceController =
          Get.find<TeacherBalanceController>();
      await Future.delayed(Duration(seconds: 3));
      await balanceController.getBalance();
      await balanceController.getTransaction();
      Get.back();
      EasyLoading.dismiss();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      EasyLoading.dismiss();
    }
  }
}
