import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/controllers/category_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/settings/controllers/settings_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/teachers/controllers/teachers_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/top_rated_teacher/controllers/top_rated_teacher_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/users/controllers/users_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/withdrawal/controllers/withdrawal_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/routes/app_pages.dart';
import 'package:hello_teacher_admin_dashboard/app/services/auth_service.dart';
import 'package:sidebarx/sidebarx.dart';

class LayoutController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  final sidebarController =
      SidebarXController(selectedIndex: 0, extended: true).obs;
  var selectedIndex = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.find<DashboardController>().onInit();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 1:
        Get.find<UsersController>().initUsersTab();
        break;
      case 2:
        Get.find<TeachersController>().initTeachersTab();
        break;
      case 3:
        Get.find<TopRatedTeacherController>().initTopRatedTeacherTab();
        break;
      case 4:
        Get.find<CategoryController>().initCategoryTab();
        break;
      case 5:
        Get.find<TransactionController>().initializeTransactionTab();
        break;
      case 6:
        Get.find<WithdrawalController>().initWithdrawTab();
        break;
      case 7:
        Get.find<SettingsController>().initSettings();
        break;
      default:
    }
  }

  Future logout() async {
    try {
      await AuthService().logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      return Future.error(e);
    }
  }
}
