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
      adminFee: json['adminFee'] as String?,
      status: json['status'] as String?,
      tax: json['tax'] as String?,
      totalWithdraw: json['totalWithdraw'] as String?,
    );

Map<String, dynamic> _$WithdrawRequestModelToJson(
        WithdrawRequestModel instance) =>
    <String, dynamic>{
      'withdrawMethod': WithdrawRequestModel.withdrawmethodmodelToJson(
          instance.withdrawMethod),
      'amount': instance.amount,
      'userId': instance.userId,
      'createdAt': WithdrawRequestModel._dateTimeToJson(instance.createdAt),
      'adminFee': instance.adminFee,
      'tax': instance.tax,
      'totalWithdraw': instance.totalWithdraw,
      'status': instance.status,
    };
