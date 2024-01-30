import 'package:flutter/material.dart';
import 'package:hello_teacher_admin_dashboard/app/models/dashboard_model.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/components/data_card.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';
import 'package:hello_teacher_admin_dashboard/responsive.dart';

class DataCount extends StatelessWidget {
  const DataCount({super.key, this.dashboardModel});
  final DashboardModel? dashboardModel;
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: DataCountGrid(
        childAspectRatio: 1,
        dashboardModel: dashboardModel,
      ),
      desktop: DataCountGrid(
        childAspectRatio: 3,
        dashboardModel: dashboardModel,
      ),
      tablet: DataCountGrid(
        childAspectRatio: 2,
        dashboardModel: dashboardModel,
      ),
    );
  }
}

class DataCountGrid extends StatelessWidget {
  const DataCountGrid(
      {super.key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 2,
      this.dashboardModel});

  final int crossAxisCount;
  final double childAspectRatio;
  final DashboardModel? dashboardModel;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Number of columns
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      children: [
        DataCard(
          name: 'Users',
          data: dashboardModel?.userCount.toString() ?? '5',
        ),
        DataCard(
          data: dashboardModel?.teacherCount.toString() ?? '',
          name: 'Teachers',
        ),
        DataCard(
          data: dashboardModel?.transactionCount.toString() ?? '',
          name: 'Transaction',
        ),
        DataCard(
            data: dashboardModel?.withdrawalCount.toString() ?? '',
            name: 'Withdrawal')
      ],
    );
  }
}
