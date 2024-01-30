import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'withdraw_method_model.g.dart';

@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class WithdrawMethodModel {
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'method')
  String? method;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  WithdrawMethodModel(
      {this.id, this.name, this.email, this.method, this.userId});
  factory WithdrawMethodModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawMethodModelToJson(this);
  factory WithdrawMethodModel.fromFirestore(DocumentSnapshot doc) =>
      WithdrawMethodModel.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;

  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
