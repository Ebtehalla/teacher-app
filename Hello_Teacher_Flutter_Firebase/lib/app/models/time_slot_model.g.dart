// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      timeSlot: TimeSlot._dateTimeFromJson(json['timeSlot'] as Timestamp?),
      duration: json['duration'] as int?,
      price: json['price'] as int?,
      available: json['available'] as bool?,
      teacherId: json['teacherId'] as String?,
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      purchaseTime:
          TimeSlot._dateTimeFromJson(json['purchaseTime'] as Timestamp?),
      status: json['status'] as String?,
      bookByWho: json['bookByWho'] == null
          ? null
          : BookByWhoModel.fromJson(json['bookByWho'] as Map<String, dynamic>),
      repeatTimeSlot: (json['repeatTimeSlot'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      parentTimeslotId: json['parentTimeslotId'] as String?,
      pastTimeSlot:
          TimeSlot._dateTimeFromJson(json['pastTimeSlot'] as Timestamp?),
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'timeSlot': TimeSlot._dateTimeToJson(instance.timeSlot),
      'duration': instance.duration,
      'price': instance.price,
      'available': instance.available,
      'teacherId': instance.teacherId,
      'teacher': TimeSlot.teacherToJson(instance.teacher),
      'purchaseTime': TimeSlot._dateTimeToJson(instance.purchaseTime),
      'status': instance.status,
      'bookByWho': instance.bookByWho,
      'repeatTimeSlot':
          instance.repeatTimeSlot?.map((e) => e.toIso8601String()).toList(),
      'parentTimeslotId': instance.parentTimeslotId,
      'pastTimeSlot': TimeSlot._dateTimeToJson(instance.pastTimeSlot),
    };
