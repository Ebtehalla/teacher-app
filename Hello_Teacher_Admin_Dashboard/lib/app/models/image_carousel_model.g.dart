// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_carousel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageCarouselModel _$ImageCarouselModelFromJson(Map<String, dynamic> json) =>
    ImageCarouselModel(
      createdAt:
          ImageCarouselModel._dateTimeFromJson(json['createdAt'] as Timestamp?),
      fileName: json['fileName'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ImageCarouselModelToJson(ImageCarouselModel instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'imageUrl': instance.imageUrl,
      'createdAt': ImageCarouselModel._dateTimeToJson(instance.createdAt),
    };
