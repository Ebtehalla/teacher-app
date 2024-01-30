import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/models/book_by_who_model.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'teacher_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'time_slot_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TimeSlot {
  TimeSlot(
      {this.timeSlot,
      this.duration,
      this.price,
      this.available,
      this.teacherId,
      this.teacher,
      this.purchaseTime,
      this.status,
      this.bookByWho,
      this.repeatTimeSlot,
      this.parentTimeslotId,
      this.pastTimeSlot});
  String? id;
  @JsonKey(
      name: 'timeSlot', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? timeSlot;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'available')
  bool? available;
  @JsonKey(name: 'teacherId')
  String? teacherId;
  @JsonKey(name: 'teacher', toJson: teacherToJson)
  Teacher? teacher;
  @JsonKey(
      name: 'purchaseTime',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  DateTime? purchaseTime;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'bookByWho')
  BookByWhoModel? bookByWho;
  @JsonKey(name: 'repeatTimeSlot')
  List<DateTime>? repeatTimeSlot;
  @JsonKey(name: 'parentTimeslotId')
  String? parentTimeslotId;
  @JsonKey(
      name: 'pastTimeSlot',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  DateTime? pastTimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
  factory TimeSlot.fromFirestore(DocumentSnapshot doc) =>
      TimeSlot.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
  static Map<String, dynamic>? teacherToJson(Teacher? teacher) =>
      teacher?.toJson();
  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
