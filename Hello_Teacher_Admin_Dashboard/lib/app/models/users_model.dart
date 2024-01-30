import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UsersModel {
  String? userId;
  @JsonKey(name: 'photoUrl')
  String? photoUrl;
  @JsonKey(name: 'teacherId')
  String? teacherId;
  @JsonKey(name: 'displayName')
  String? displayName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(
      name: 'lastLogin', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? lastLogin;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  @JsonKey(name: 'role')
  String? role;
  @JsonKey(name: 'token', fromJson: tokenFromJson, toJson: tokenToJson)
  List<String>? token;

  UsersModel(
      {this.userId,
      this.photoUrl,
      this.teacherId,
      this.displayName,
      this.email,
      this.createdAt,
      this.lastLogin,
      this.role,
      this.token});
  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
  factory UsersModel.fromFirestore(DocumentSnapshot doc) =>
      UsersModel.fromJson(doc.data()! as Map<String, dynamic>)..userId = doc.id;

  static DateTime? _dateTimeFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return (timestamp).toDate();
    } else if (timestamp is int) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return date;
    } else {
      return null;
    }
  }

  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }

  static List<String>? tokenToJson(List<String>? tokens) => tokens;
  static List<String>? tokenFromJson(dynamic tokens) {
    if (tokens is List<dynamic>) {
      return tokens.map((e) => e.toString()).toList();
    } else {
      if (tokens == null) {
        return null;
      } else {
        List<String> newListToken = [tokens as String];

        return newListToken;
      }
    }
  }
}
