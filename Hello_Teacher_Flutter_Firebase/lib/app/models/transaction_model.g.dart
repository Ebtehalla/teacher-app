// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      withdrawMethod: json['withdrawMethod'] == null
          ? null
          : WithdrawMethodModel.fromJson(
              json['withdrawMethod'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
      amount: json['amount'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      timeSlot: json['timeslot'] == null
          ? null
          : TimeSlot.fromJson(json['timeslot'] as Map<String, dynamic>),
      createdAt:
          TransactionModel._dateTimeFromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'withdrawMethod': instance.withdrawMethod,
      'userId': instance.userId,
      'amount': instance.amount,
      'status': instance.status,
      'type': instance.type,
      'timeslot': instance.timeSlot,
      'createdAt': TransactionModel._dateTimeToJson(instance.createdAt),
    };
