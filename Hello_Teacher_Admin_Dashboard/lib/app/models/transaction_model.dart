import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_teacher_admin_dashboard/app/models/withdrawal_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TransactionModel {
  String? id;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'withdrawMethod', toJson: withdrawmethodToJson)
  WithdrawMethodModel? withdrawMethod;
  @JsonKey(name: 'withdrawRequestId')
  String? withdrawRequestId;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(
      name: 'updatedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? updatedAt;
  TransactionModel(
      {this.id,
      this.amount,
      this.createdAt,
      this.status,
      this.type,
      this.withdrawMethod,
      this.userId,
      this.withdrawRequestId});
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) =>
      TransactionModel.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;
  static Map<String, dynamic>? withdrawmethodToJson(
          WithdrawMethodModel? withdrawmethod) =>
      withdrawmethod?.toJson();
  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
