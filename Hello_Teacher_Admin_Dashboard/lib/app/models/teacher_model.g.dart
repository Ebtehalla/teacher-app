// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
      userId: json['userId'] as String?,
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      picture: json['picture'] as String?,
      basePrice: json['basePrice'] as int?,
      shortBiography: json['biography'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      education: json['education'] as String?,
      accountStatus: json['accountStatus'] as String?,
      balance: json['balance'] as int?,
      createdAt:
          TeacherModel._dateTimeFromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          TeacherModel._dateTimeFromJson(json['updatedAt'] as Timestamp?),
    )..topRated = json['topRated'] as bool?;

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('email', instance.email);
  val['id'] = instance.id;
  writeNotNull('name', instance.name);
  writeNotNull('picture', instance.picture);
  writeNotNull('basePrice', instance.basePrice);
  writeNotNull('biography', instance.shortBiography);
  writeNotNull('category', TeacherModel.categoryToJson(instance.category));
  writeNotNull('education', instance.education);
  writeNotNull('balance', instance.balance);
  writeNotNull('createdAt', TeacherModel._dateTimeToJson(instance.createdAt));
  writeNotNull('updatedAt', TeacherModel._dateTimeToJson(instance.updatedAt));
  writeNotNull('accountStatus', instance.accountStatus);
  writeNotNull('topRated', instance.topRated);
  return val;
}
