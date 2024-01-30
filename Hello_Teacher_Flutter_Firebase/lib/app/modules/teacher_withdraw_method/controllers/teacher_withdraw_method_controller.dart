import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/withdraw_method_model.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/withdraw_service.dart';

class TeacherWithdrawMethodController extends GetxController
    with StateMixin<List<WithdrawMethodModel>> {
  final amount = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    getAllPaymentMethod();
  }

  void addPaypal(String name, String email) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    WithdrawService().addPaypalMethod(name, email).then((value) {
      Get.back();
      getAllPaymentMethod();
    }).whenComplete(() => EasyLoading.dismiss());
  }

  getAllPaymentMethod() async {
    change([], status: RxStatus.loading());
    WithdrawService().getWithdrawMethod().then((value) {
      if (value.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      change([], status: RxStatus.error(err.toString()));
    });
  }

  toWithdrawDetail(WithdrawMethodModel withdrawMethod) {
    Get.toNamed(Routes.TEACHER_WITHDRAW_DETAIL, arguments: [
      {'withdrawMethod': withdrawMethod, 'amount': amount}
    ]);
  }
}
