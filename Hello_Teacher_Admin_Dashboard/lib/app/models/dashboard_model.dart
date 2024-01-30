import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dashboard_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class DashboardModel {
  String? id;
  int? userCount;
  int? teacherCount;
  int? transactionCount;
  int? withdrawalCount;
  DashboardModel(
      {this.id,
      this.userCount,
      this.teacherCount,
      this.transactionCount,
      this.withdrawalCount});
  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);
  factory DashboardModel.fromFirestore(DocumentSnapshot doc) =>
      DashboardModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
