import 'category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'teacher_model.g.dart';

@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class Teacher {
  Teacher(
      {this.userId,
      this.id,
      this.name,
      this.email,
      this.picture,
      this.basePrice,
      this.shortBiography,
      this.category,
      this.education,
      this.accountStatus,
      this.balance,
      this.createdAt,
      this.updatedAt});
  String? id;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'picture')
  String? picture;
  @JsonKey(name: 'basePrice')
  int? basePrice;
  @JsonKey(name: 'biography')
  String? shortBiography;
  @JsonKey(name: 'category', toJson: categoryToJson)
  CategoryModel? category;
  @JsonKey(name: 'education')
  String? education;
  @JsonKey(name: 'balance')
  int? balance;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  @JsonKey(
      name: 'updatedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? updatedAt;
  @JsonKey(name: 'accountStatus')
  String? accountStatus;
  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
  factory Teacher.fromFirestore(DocumentSnapshot doc) =>
      Teacher.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
  static Map<String, dynamic>? categoryToJson(CategoryModel? category) =>
      category?.toJson();
  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
