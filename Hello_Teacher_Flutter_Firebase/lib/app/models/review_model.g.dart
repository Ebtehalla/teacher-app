// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      rating: json['rating'] as int?,
      review: json['review'] as String?,
      timeSlotId: json['timeSlotId'] as String?,
      userId: json['userId'] as String?,
      teacherId: json['teacherId'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'review': instance.review,
      'timeSlotId': instance.timeSlotId,
      'userId': instance.userId,
      'teacherId': instance.teacherId,
      'user': ReviewModel.usermodelToJson(instance.user),
    };
