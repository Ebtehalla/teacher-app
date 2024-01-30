// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawMethodModel _$WithdrawMethodModelFromJson(Map<String, dynamic> json) =>
    WithdrawMethodModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      method: json['method'] as String?,
      userId: json['userId'] as String?,
    )..createdAt =
        WithdrawMethodModel._dateTimeFromJson(json['createdAt'] as Timestamp?);

Map<String, dynamic> _$WithdrawMethodModelToJson(WithdrawMethodModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('method', instance.method);
  writeNotNull('userId', instance.userId);
  writeNotNull(
      'createdAt', WithdrawMethodModel._dateTimeToJson(instance.createdAt));
  return val;
}
