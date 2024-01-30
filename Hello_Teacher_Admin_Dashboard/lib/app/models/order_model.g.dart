// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      charged: json['charged'] as bool?,
      amount: json['amount'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      currency: json['currency'] as String?,
      linkReceipt: json['linkReceipt'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      stripePaymentId: json['stripePaymentId'] as String?,
      timeSlotId: json['timeSlotId'] as String?,
      userId: json['userId'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'charged': instance.charged,
      'amount': instance.amount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'currency': instance.currency,
      'linkReceipt': instance.linkReceipt,
      'paymentMethod': instance.paymentMethod,
      'stripePaymentId': instance.stripePaymentId,
      'timeSlotId': instance.timeSlotId,
      'userId': instance.userId,
      'status': instance.status,
    };
