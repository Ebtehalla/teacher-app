// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      amount: json['amount'] as int?,
      createdAt:
          TransactionModel._dateTimeFromJson(json['createdAt'] as Timestamp?),
      status: json['status'] as String?,
      type: json['type'] as String?,
      withdrawMethod: json['withdrawMethod'] == null
          ? null
          : WithdrawMethodModel.fromJson(
              json['withdrawMethod'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
      withdrawRequestId: json['withdrawRequestId'] as String?,
    )..updatedAt =
        TransactionModel._dateTimeFromJson(json['updatedAt'] as Timestamp?);

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'createdAt': TransactionModel._dateTimeToJson(instance.createdAt),
      'status': instance.status,
      'type': instance.type,
      'withdrawMethod':
          TransactionModel.withdrawmethodToJson(instance.withdrawMethod),
      'withdrawRequestId': instance.withdrawRequestId,
      'userId': instance.userId,
      'updatedAt': TransactionModel._dateTimeToJson(instance.updatedAt),
    };
