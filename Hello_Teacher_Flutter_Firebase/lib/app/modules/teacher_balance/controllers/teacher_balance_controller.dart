import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/transaction_model.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/balance_service.dart';
import 'package:halo_teacher/app/services/transaction_service.dart';

class TeacherBalanceController extends GetxController
    with StateMixin<List<TransactionModel>> {
  var balance = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    initBalance();
  }

  initBalance() async {
    await getBalance();
    await getTransaction();
  }

  Future getTransaction() async {
    change([], status: RxStatus.loading());
    try {
      var transaction = await TransactionService().getAllTransaction();
      if (transaction.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(transaction, status: RxStatus.success());
    } catch (err) {
      change([], status: RxStatus.error());
    }
  }

  getBalance() async {
    try {
      balance.value = await BalanceService().getBalance();
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  withdraw() {
    Get.toNamed(Routes.TEACHER_WITHDRAW_METHOD, arguments: balance.value);
  }
}
