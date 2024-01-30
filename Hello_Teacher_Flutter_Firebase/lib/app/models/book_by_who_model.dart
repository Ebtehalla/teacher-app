import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book_by_who_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class BookByWhoModel {
  String? id;
  @JsonKey(name: 'displayName')
  String? displayName;
  @JsonKey(name: 'photoUrl')
  String? photoUrl;
  @JsonKey(name: 'userId')
  String? userId;
  BookByWhoModel({this.id});
  factory BookByWhoModel.fromJson(Map<String, dynamic> json) =>
      _$BookByWhoModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookByWhoModelToJson(this);
  factory BookByWhoModel.fromFirestore(DocumentSnapshot doc) =>
      BookByWhoModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
