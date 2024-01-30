import 'package:get/get.dart';

import '../controllers/withdraw_finish_controller.dart';

class WithdrawFinishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawFinishController>(
      () => WithdrawFinishController(),
    );
  }
}
