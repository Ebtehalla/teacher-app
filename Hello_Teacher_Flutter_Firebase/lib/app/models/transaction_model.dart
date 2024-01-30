import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/models/withdraw_method_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TransactionModel {
  String? id;
  @JsonKey(name: 'withdrawMethod')
  WithdrawMethodModel? withdrawMethod;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'timeslot')
  TimeSlot? timeSlot;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  TransactionModel(
      {this.id,
      this.withdrawMethod,
      this.userId,
      this.amount,
      this.status,
      this.type,
      this.timeSlot,
      this.createdAt});
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) =>
      TransactionModel.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;

  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}

enum TransactionType { withdraw, payment }
