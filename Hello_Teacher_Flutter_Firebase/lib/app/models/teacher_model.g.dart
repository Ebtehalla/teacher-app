// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      userId: json['userId'] as String?,
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
      createdAt: Teacher._dateTimeFromJson(json['createdAt'] as Timestamp?),
      updatedAt: Teacher._dateTimeFromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('email', instance.email);
  writeNotNull('name', instance.name);
  writeNotNull('picture', instance.picture);
  writeNotNull('basePrice', instance.basePrice);
  writeNotNull('biography', instance.shortBiography);
  writeNotNull('category', Teacher.categoryToJson(instance.category));
  writeNotNull('education', instance.education);
  writeNotNull('balance', instance.balance);
  writeNotNull('createdAt', Teacher._dateTimeToJson(instance.createdAt));
  writeNotNull('updatedAt', Teacher._dateTimeToJson(instance.updatedAt));
  writeNotNull('accountStatus', instance.accountStatus);
  return val;
}
