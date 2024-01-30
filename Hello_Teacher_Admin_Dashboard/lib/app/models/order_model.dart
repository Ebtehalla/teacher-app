import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class OrderModel {
  String? id;
  @JsonKey(name: 'charged')
  bool? charged;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'linkReceipt')
  String? linkReceipt;
  @JsonKey(name: 'paymentMethod')
  String? paymentMethod;
  @JsonKey(name: 'stripePaymentId')
  String? stripePaymentId;
  @JsonKey(name: 'timeSlotId')
  String? timeSlotId;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'status')
  String? status;
  OrderModel(
      {this.id,
      this.charged,
      this.amount,
      this.createdAt,
      this.currency,
      this.linkReceipt,
      this.paymentMethod,
      this.stripePaymentId,
      this.timeSlotId,
      this.userId,
      this.status});
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
  factory OrderModel.fromFirestore(DocumentSnapshot doc) =>
      OrderModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
