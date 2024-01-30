import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'top_rated_teacher_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TopRatedTeacher {
  String? id;
  @JsonKey(name: 'teacherId')
  String? teacherId;
  TopRatedTeacher({this.id, this.teacherId});
  factory TopRatedTeacher.fromJson(Map<String, dynamic> json) =>
      _$TopRatedTeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TopRatedTeacherToJson(this);
  factory TopRatedTeacher.fromFirestore(DocumentSnapshot doc) =>
      TopRatedTeacher.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;
}
