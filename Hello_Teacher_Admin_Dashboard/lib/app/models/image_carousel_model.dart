import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_carousel_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ImageCarouselModel {
  String? id;
  @JsonKey(name: 'fileName')
  String? fileName;
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  ImageCarouselModel({this.id, this.createdAt, this.fileName, this.imageUrl});
  factory ImageCarouselModel.fromJson(Map<String, dynamic> json) =>
      _$ImageCarouselModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageCarouselModelToJson(this);
  factory ImageCarouselModel.fromFirestore(DocumentSnapshot doc) =>
      ImageCarouselModel.fromJson(doc.data()! as Map<String, dynamic>)
        ..id = doc.id;
  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
