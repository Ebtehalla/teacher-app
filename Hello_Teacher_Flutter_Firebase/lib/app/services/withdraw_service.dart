import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/withdraw_method_model.dart';
import 'package:halo_teacher/app/models/withdraw_request_model.dart';
import 'package:halo_teacher/app/models/withdraw_settings_detail.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class WithdrawService {
  Future<void> addPaypalMethod(String name, String email) async {
    try {
      WithdrawMethodModel newWithdrawMethod = WithdrawMethodModel(
          name: name,
          email: email,
          method: 'paypal',
          userId: UserService().currentUserFirebase!.uid);
      await FirebaseCollection().withdrawMethodCol.add(newWithdrawMethod);
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<List<WithdrawMethodModel>> getWithdrawMethod() async {
    try {
      var withdrawMethodRef = await FirebaseCollection()
          .withdrawMethodCol
          .where(
            'userId',
            isEqualTo: UserService().currentUserFirebase!.uid,
          )
          .get();

      List<WithdrawMethodModel> listWithdrawMethod =
          withdrawMethodRef.docs.map((doc) => doc.data()).toList();

      if (listWithdrawMethod.isEmpty) return [];
      return listWithdrawMethod;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future requestWithdraw(
      String password, WithdrawMethodModel withdrawMethod, int amount) async {
    try {
      bool verifyPassword = await AuthService().verifyPassword(password);
      if (verifyPassword) {
        WithdrawRequestModel newWithdraRequest = WithdrawRequestModel(
            amount: amount,
            withdrawMethod: withdrawMethod,
            createdAt: DateTime.now(),
            userId: UserService().currentUserFirebase!.uid);
        await FirebaseCollection().withdrawRequestCol.add(newWithdraRequest);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<WithdrawSettingsDetail> getWithdrawSettings() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Settings')
          .doc('withdrawSettings')
          .get();
      WithdrawSettingsDetail withdrawSettingsDetail =
          WithdrawSettingsDetail.fromFirestore(snapshot);
      return withdrawSettingsDetail;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
