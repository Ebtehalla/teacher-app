import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/components/data_count.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return DataCount(
        dashboardModel: state,
      );
    },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
