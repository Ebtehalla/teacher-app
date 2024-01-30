import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'top_rated_teacher_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TopRatedTeacherModel {
  String? id;
  @JsonKey(name: 'teacherId')
  String? teacherId;
  TopRatedTeacherModel({this.id, this.teacherId});
  factory TopRatedTeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TopRatedTeacherModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopRatedTeacherModelToJson(this);
  factory TopRatedTeacherModel.fromFirestore(DocumentSnapshot doc) =>
      TopRatedTeacherModel.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;
}
