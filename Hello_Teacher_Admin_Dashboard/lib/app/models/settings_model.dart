import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'settings_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class SettingsModel {
  String? id;
  @JsonKey(name: 'percentage')
  int? percentage;
  @JsonKey(name: 'tax')
  int? tax;
  SettingsModel({this.id, this.percentage, this.tax});
  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
  factory SettingsModel.fromFirestore(DocumentSnapshot doc) =>
      SettingsModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
