import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/views/category_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/settings/views/settings_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/teachers/views/teachers_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/top_rated_teacher/views/top_rated_teacher_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/transaction/views/transaction_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/users/views/users_view.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/withdrawal/views/withdrawal_view.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';
import 'package:hello_teacher_admin_dashboard/responsive.dart';

import '../controllers/layout_controller.dart';
import 'widgets/header.dart';
import 'widgets/side_menu.dart';

class LayoutView extends GetView<LayoutController> {
  LayoutView({Key? key}) : super(key: key);
  final List<Widget> bodyContent = [
    DashboardView(),
    UsersView(),
    const TeachersView(),
    const TopRatedTeacherView(),
    const CategoryView(),
    const TransactionView(),
    const WithdrawalView(),
    SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: SideMenu(
        controller: controller.sidebarController.value,
        onItemSelected: (index) {
          controller.changeSelectedIndex(index);
        },
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(
                  controller: controller.sidebarController.value,
                  onItemSelected: (index) {
                    controller.changeSelectedIndex(index);
                  },
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                primary: false,
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Header(
                      onPress: () {
                        controller.controlMenu();
                      },
                    ),
                    const SizedBox(height: defaultPadding),
                    // const UsersView()
                    Obx(
                      () => Center(
                        child: IndexedStack(
                            index: controller.selectedIndex.value,
                            children: bodyContent),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
