import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_teacher_admin_dashboard/app/models/dashboard_model.dart';

class DashboardService {
  Future<DashboardModel> getDashboardData() async {
    try {
      var userCount = await FirebaseFirestore.instance
          .collection("Users")
          .where('role', isEqualTo: 'user')
          .count()
          .get();
      userCount.count;
      var teacherCount =
          await FirebaseFirestore.instance.collection("Teachers").count().get();
      var transactionCount = await FirebaseFirestore.instance
          .collection("Transaction")
          .count()
          .get();
      var withdrawalCount = await FirebaseFirestore.instance
          .collection("WithdrawRequest")
          .count()
          .get();
      DashboardModel dashboardModel = DashboardModel(
          userCount: userCount.count,
          teacherCount: teacherCount.count,
          transactionCount: transactionCount.count,
          withdrawalCount: withdrawalCount.count);
      return dashboardModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
