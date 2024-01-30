import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class CategoryModel {
  String? id;
  @JsonKey(name: 'categoryId')
  String? categoryId;
  @JsonKey(name: 'categoryName')
  String? categoryName;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  CategoryModel({this.id, this.categoryId, this.categoryName, this.iconUrl});
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
  factory CategoryModel.fromFirestore(DocumentSnapshot doc) =>
      CategoryModel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
