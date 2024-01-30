// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_settings_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawSettingsDetail _$WithdrawSettingsDetailFromJson(
        Map<String, dynamic> json) =>
    WithdrawSettingsDetail(
      percentage: json['percentage'] as int? ?? 0,
      tax: json['tax'] as int? ?? 0,
    );

Map<String, dynamic> _$WithdrawSettingsDetailToJson(
    WithdrawSettingsDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('percentage', instance.percentage);
  writeNotNull('tax', instance.tax);
  return val;
}
