import 'package:halo_teacher/app/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ReviewModel {
  String? id;
  @JsonKey(name: 'rating')
  int? rating;
  @JsonKey(name: 'review')
  String? review;
  @JsonKey(name: 'timeSlotId')
  String? timeSlotId;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'teacherId')
  String? teacherId;
  @JsonKey(name: 'user', toJson: usermodelToJson)
  UserModel? user;
  ReviewModel(
      {this.id,
      this.rating,
      this.review,
      this.timeSlotId,
      this.userId,
      this.teacherId,
      this.user});
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
  factory ReviewModel.fromFirestore(DocumentSnapshot doc) =>
      ReviewModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;

  static Map<String, dynamic>? usermodelToJson(UserModel? usermodel) =>
      usermodel?.toJson();
}
