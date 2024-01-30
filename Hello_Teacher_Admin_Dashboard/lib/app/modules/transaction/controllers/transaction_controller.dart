import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/models/transaction_model.dart';
import 'package:hello_teacher_admin_dashboard/app/services/transaction_service.dart';

class TransactionController extends GetxController
    with StateMixin<List<TransactionModel>> {
  List<TransactionModel>? listTransaction;
  @override
  void onInit() {
    super.onInit();
  }

  void initializeTransactionTab() async {
    try {
      listTransaction = await TransactionService().getAllTransaction();
      change(listTransaction, status: RxStatus.success());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
