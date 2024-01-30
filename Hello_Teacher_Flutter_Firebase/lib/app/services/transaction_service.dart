import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/transaction_model.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class TransactionService {
  Future<List<TransactionModel>> getAllTransaction() async {
    try {
      var transactionSnapshot = await FirebaseCollection()
          .transactionCol
          .where('userId', isEqualTo: UserService().currentUserFirebase!.uid)
          .get();
      List<TransactionModel> listTransaction =
          transactionSnapshot.docs.map((e) => e.data()).toList();
      if (listTransaction.isEmpty) return [];
      return listTransaction;
    } on FirebaseException catch (e) {
      return Future.error(e.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
