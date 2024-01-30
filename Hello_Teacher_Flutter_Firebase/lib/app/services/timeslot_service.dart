import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/collection/firebase_collection.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';

class TimeSlotService {
  Future<List<TimeSlot>> getListAppointment(User user) async {
    try {
      var userId = user.uid;
      var listTimeSlotCol = await FirebaseCollection()
          .timeSlotCol
          .where('bookByWho.userId', isEqualTo: userId)
          .where('charged', isEqualTo: true)
          .get();

      if (listTimeSlotCol.docs.isEmpty) {
        return [];
      }
      List<TimeSlot> listTimeslot =
          listTimeSlotCol.docs.map((doc) => doc.data()).toList();
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<TimeSlot?> getTimeSlotById(String timeslotId) async {
    try {
      var timeslotRef =
          await FirebaseCollection().timeSlotCol.doc(timeslotId).get();
      if (!timeslotRef.exists) return null;
      var timeSlot = timeslotRef.data();
      return timeSlot!;
    } catch (e) {
      return Future.error(e);
    }
  }

  ///save teacher timeslot, and return timeslotId
  Future<String> saveTeacherTimeslot(
      {required DateTime dateTime,
      required int price,
      required int duration,
      required bool available,
      bool isParentTimeslot = false}) async {
    var currentTeacher = await TeacherService.getCurrentTeacher();
    TimeSlot timeSlot = TimeSlot(
        timeSlot: dateTime,
        price: price,
        duration: duration,
        available: available,
        teacherId: currentTeacher?.id,
        teacher: Teacher(
            id: currentTeacher!.id,
            picture: currentTeacher.picture,
            name: currentTeacher.name));
    try {
      if (isParentTimeslot) {
        var timeSlotSaved =
            await FirebaseCollection().timeSlotCol.add(timeSlot);
        timeSlotSaved.update({"parentTimeslotId": timeSlotSaved.id});
        return timeSlotSaved.id;
      } else {
        var timeSlotSaved =
            await FirebaseCollection().timeSlotCol.add(timeSlot);
        return timeSlotSaved.id;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future saveMultipleTimeslot(
      {required DateTime dateTime,
      required int price,
      required int duration,
      required bool available,
      required List<DateTime> repeatTimeslot,
      required parentTimeslotId}) async {
    var batch = FirebaseFirestore.instance.batch();
    var currentTeacher = await TeacherService.getCurrentTeacher();
    TimeSlot timeSlot = TimeSlot();
    timeSlot.timeSlot = dateTime;
    timeSlot.price = price;
    timeSlot.duration = duration;
    timeSlot.available = available;
    timeSlot.teacherId = currentTeacher?.id;
    timeSlot.parentTimeslotId = parentTimeslotId;
    timeSlot.teacher = Teacher(
        id: currentTeacher!.id,
        picture: currentTeacher.picture,
        name: currentTeacher.name);
    for (var dateTime in repeatTimeslot) {
      // var docRef = FirebaseFirestore.instance.collection("TimeSlot").doc();
      var docRef = FirebaseCollection().timeSlotCol.doc();
      timeSlot.timeSlot = dateTime;
      batch.set<TimeSlot>(docRef, timeSlot);
    }

    await batch.commit();
  }

  Future updateTimeSlot(TimeSlot timeSlot) async {
    try {
      await FirebaseCollection()
          .timeSlotCol
          .doc(timeSlot.id)
          .update(timeSlot.toJson());
    } catch (e) {
      return Future.error(e);
    }
  }

  ///delete one timeslot, use deleteRepeatedTimeslot to delete multiple timeslot
  Future deleteTimeSlot(TimeSlot timeSlot) async {
    try {
      await FirebaseCollection().timeSlotCol.doc(timeSlot.id).delete();
      printInfo(info: 'success delete timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  ///Delete all timeslot with the same parent id, only delte available timeslot
  Future deleteRepeatedTimeSlot(TimeSlot timeSlot) async {
    try {
      var batch = FirebaseFirestore.instance.batch();
      var docRef = await FirebaseCollection()
          .timeSlotCol
          .where('parentTimeslotId', isEqualTo: timeSlot.parentTimeslotId)
          .where('available', isEqualTo: true)
          .get();
      for (var item in docRef.docs) {
        batch.delete(item.reference);
      }
      await batch.commit();
      print('success delete timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future rescheduleTimeslot(
      TimeSlot timeSlotNow, TimeSlot timeslotChanged) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('rescheduleTimeslot');
      await callable({
        'timeSlotIdNow': timeSlotNow.id,
        'timeslotChanged': timeslotChanged.id
      });
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }

  ///get all timeslot that user, succesfully purchase
  Future<List<TimeSlot>> getOrderedTimeSlot({int? limit}) async {
    try {
      var teacher = await TeacherService.getCurrentTeacher();
      var documentRef = FirebaseCollection()
          .timeSlotCol
          .where('teacherId', isEqualTo: teacher?.id)
          .where('charged', isEqualTo: true);
      var documentSnapshot = limit == null
          ? await documentRef.get()
          : await documentRef.limit(limit).get();

      if (documentSnapshot.docs.isEmpty) {
        return [];
      }
      var listTimeSlot = documentSnapshot.docs.map((e) => e.data()).toList();
      return listTimeSlot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<TimeSlot>> getTeacherTimeSlot() async {
    try {
      var currentTeacher = await TeacherService.getCurrentTeacher();
      var documentRef = await FirebaseCollection()
          .timeSlotCol
          .where('teacherId', isEqualTo: currentTeacher?.id)
          .get();
      if (documentRef.docs.isEmpty) return [];

      List<TimeSlot> listTimeslot =
          documentRef.docs.map((doc) => doc.data()).toList();
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  ///Update all timeslot with the same parent id, only update available timeslot
  Future updateRepeatedTimeSlot(TimeSlot timeSlot) async {
    try {
      if (timeSlot.parentTimeslotId == null) {
        return Future.error('timeslot parent null');
      }
      var batch = FirebaseFirestore.instance.batch();
      var docRef = await FirebaseCollection()
          .timeSlotCol
          .where('parentTimeslotId', isEqualTo: timeSlot.parentTimeslotId)
          .where('available', isEqualTo: true)
          .get();

      for (var item in docRef.docs) {
        var myTimeSlot = item.data();
        var updatedHourTimeSlot = DateTime(
            myTimeSlot.timeSlot!.year,
            myTimeSlot.timeSlot!.month,
            myTimeSlot.timeSlot!.day,
            timeSlot.timeSlot!.hour,
            timeSlot.timeSlot!.minute,
            timeSlot.timeSlot!.second,
            timeSlot.timeSlot!.millisecond,
            timeSlot.timeSlot!.microsecond);
        timeSlot.timeSlot = updatedHourTimeSlot;
        batch.update(item.reference, timeSlot.toJson());
      }
      await batch.commit();
      print('success edit timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future cancelAppointment(TimeSlot timeSlot) async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('refundTimeslot');
      await callable({'timeSlotId': timeSlot.id});
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
