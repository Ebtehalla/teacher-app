import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_teacher_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_teacher_admin_dashboard/app/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>> getAllTransaction() async {
    try {
      var transactionRef = await FirebaseCollection().transactionCol.get();
      if (transactionRef.docs.isEmpty) return [];
      List<TransactionModel> listTransaction =
          transactionRef.docs.map((doc) => doc.data()).toList();
      return listTransaction;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future setWithdrawTransactionComplete(String withdrawRequestId) async {
    try {
      var transactionRef = await FirebaseCollection()
          .transactionCol
          .where('withdrawRequestId', isEqualTo: withdrawRequestId)
          .get();
      if (transactionRef.docs.isEmpty) throw Exception('transaction not found');
      transactionRef.docs.first.reference.update({
        'status': 'success',
        'updatedAt': Timestamp.fromDate(DateTime.now())
      });
    } catch (e) {
      return Future.error(e);
    }
  }
}
