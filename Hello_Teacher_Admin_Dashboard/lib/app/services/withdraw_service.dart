import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_teacher_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_teacher_admin_dashboard/app/models/withdraw_request_model.dart';

class WithdrawService {
  Future<List<WithdrawRequestModel>> getWithdrawRequest() async {
    try {
      var withdrawRequestRef =
          await FirebaseCollection().withdrawRequestCol.get();
      if (withdrawRequestRef.docs.isEmpty) return [];
      List<WithdrawRequestModel> listWithdrawRequest =
          withdrawRequestRef.docs.map((doc) => doc.data()).toList();
      return listWithdrawRequest;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future markWithdrawalCompleted(String withdrawalRequestId) async {
    try {
      FirebaseCollection().withdrawRequestCol.doc(withdrawalRequestId).update({
        'status': 'completed',
        'completedAt': Timestamp.fromDate(DateTime.now())
      });
    } catch (e) {
      return Future.error(e);
    }
  }
}
