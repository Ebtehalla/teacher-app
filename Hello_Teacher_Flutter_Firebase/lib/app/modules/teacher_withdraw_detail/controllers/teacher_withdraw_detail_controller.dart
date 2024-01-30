import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/withdraw_method_model.dart';
import 'package:halo_teacher/app/models/withdraw_settings_detail.dart';
import 'package:halo_teacher/app/modules/teacher_withdraw_detail/views/pages/password_confimation_page.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/withdraw_service.dart';

class TeacherWithdrawDetailController extends GetxController {
  var pass = ''.obs;
  WithdrawMethodModel withdrawMethod = Get.arguments[0]['withdrawMethod'];
  int amount = Get.arguments[0]['amount'];
  WithdrawSettingsDetail? withdrawSettingsDetail;
  double? total;
  double? percentageCut;
  double? percentageTaxCut;
  @override
  void onInit() async {
    super.onInit();
    try {
      EasyLoading.show();
      withdrawSettingsDetail = await WithdrawService().getWithdrawSettings();
      percentageCut = ((amount / 100) * withdrawSettingsDetail!.percentage!);
      percentageTaxCut = ((amount / 100) * withdrawSettingsDetail!.tax!);
      total = amount - (percentageCut! + percentageTaxCut!);
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  requestWithdraw() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    WithdrawService()
        .requestWithdraw(pass.value, withdrawMethod, amount)
        .then((value) {
      Get.offNamedUntil(
          Routes.WITHDRAW_FINISH, ModalRoute.withName(Routes.TEACHER_BALANCE));
      pass.value = '';
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }).whenComplete(() => EasyLoading.dismiss());
  }

  toPasswordConfirmation() {
    if (amount <= 0) {
      return Get.defaultDialog(
          content: Text('your balance is not sufficient to withdraw'));
    }
    Get.to(() => PasswordConfirmationPage());
  }
}
