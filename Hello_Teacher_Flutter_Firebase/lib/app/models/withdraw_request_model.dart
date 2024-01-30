import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/models/withdraw_method_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'withdraw_request_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class WithdrawRequestModel {
  String? id;
  @JsonKey(name: 'withdrawMethod', toJson: withdrawmethodmodelToJson)
  WithdrawMethodModel? withdrawMethod;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(
      name: 'createdAt', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  DateTime? createdAt;
  WithdrawRequestModel(
      {this.id, this.withdrawMethod, this.amount, this.userId, this.createdAt});
  factory WithdrawRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawRequestModelToJson(this);
  factory WithdrawRequestModel.fromFirestore(DocumentSnapshot doc) =>
      WithdrawRequestModel.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;

  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }

  static Map<String, dynamic>? withdrawmethodmodelToJson(
          WithdrawMethodModel? withdrawmethodmodel) =>
      withdrawmethodmodel?.toJson();
}
