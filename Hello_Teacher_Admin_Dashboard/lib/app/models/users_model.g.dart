// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
      photoUrl: json['photoUrl'] as String?,
      teacherId: json['teacherId'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      createdAt: UsersModel._dateTimeFromJson(json['createdAt']),
      lastLogin: UsersModel._dateTimeFromJson(json['lastLogin']),
      role: json['role'] as String?,
      token: UsersModel.tokenFromJson(json['token']),
    );

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'photoUrl': instance.photoUrl,
      'teacherId': instance.teacherId,
      'displayName': instance.displayName,
      'email': instance.email,
      'lastLogin': UsersModel._dateTimeToJson(instance.lastLogin),
      'createdAt': UsersModel._dateTimeToJson(instance.createdAt),
      'role': instance.role,
      'token': UsersModel.tokenToJson(instance.token),
    };
