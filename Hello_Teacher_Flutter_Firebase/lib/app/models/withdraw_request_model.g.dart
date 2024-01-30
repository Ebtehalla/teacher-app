// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawRequestModel _$WithdrawRequestModelFromJson(
        Map<String, dynamic> json) =>
    WithdrawRequestModel(
      withdrawMethod: json['withdrawMethod'] == null
          ? null
          : WithdrawMethodModel.fromJson(
              json['withdrawMethod'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
      userId: json['userId'] as String?,
      createdAt: WithdrawRequestModel._dateTimeFromJson(
          json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$WithdrawRequestModelToJson(
        WithdrawRequestModel instance) =>
    <String, dynamic>{
      'withdrawMethod': WithdrawRequestModel.withdrawmethodmodelToJson(
          instance.withdrawMethod),
      'amount': instance.amount,
      'userId': instance.userId,
      'createdAt': WithdrawRequestModel._dateTimeToJson(instance.createdAt),
    };
