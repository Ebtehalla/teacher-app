import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/order_model.dart' as orderModel;
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/order_service.dart';
import 'package:halo_teacher/app/services/videocall_service.dart';

class AppointmentDetailController extends GetxController
    with StateMixin<TimeSlot> {
  final count = 0.obs;
  VideoCallService videoCallService = Get.find();
  var videoCallStatus = false.obs;
  //ParseObject? room;
  TimeSlot selectedTimeslot = Get.arguments;
  late Teacher teacher;
  late orderModel.Order order;
  late String token;
  var database = FirebaseDatabase.instance.ref();
  late StreamSubscription _roomStreaming;
  var active = true.obs;
  @override
  void onInit() async {
    super.onInit();
    TeacherService().getTeacherDetail(selectedTimeslot.teacherId!).then(
      (doc) {
        selectedTimeslot.teacher = doc;
        teacher = doc;
        change(selectedTimeslot, status: RxStatus.success());
        if (selectedTimeslot.status == 'refund') {
          Get.defaultDialog(
              title: 'Appointment Canceled'.tr,
              content: Text(
                  'the Teacher has canceled the appointment, and your payment has been refunded'
                      .tr),
              onConfirm: () {
                Get.back();
              });
        }
      },
    );
    var roomSnapshot = FirebaseFirestore.instance
        .collection('RoomVideoCall')
        .doc(selectedTimeslot.id!)
        .snapshots();

    _roomStreaming = roomSnapshot.listen((event) async {
      if (event.data() == null) {
        videoCallStatus.value = false;
      } else {
        await Future.delayed(const Duration(seconds: 3), () {
          videoCallStatus.value = true;
          token = event.data()!['token'];
        });
      }
    });
  }

  @override
  void onClose() {
    _roomStreaming.cancel();
  }

  void startVideoCall() {
    if (videoCallStatus.value) {
      videoCallStatus.value = false;
      Get.toNamed('/video-call', arguments: [
        {
          'timeSlot': selectedTimeslot,
          'room': selectedTimeslot.id,
          'token': token
        }
      ]);
    } else {
      if (selectedTimeslot.status == 'refund') {
        Fluttertoast.showToast(
            msg:
                'the Teacher has canceled the appointment, and your payment has been refunded'
                    .tr,
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg:
                'the Teacher has not started the meeting session, this button will automatically turn on when the Teacher has started it'
                    .tr,
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  toConsultationConfirm() {
    Get.toNamed('/consultation-confirm', arguments: selectedTimeslot);
  }

  Future getOrder() async {
    try {
      order = await OrderService().getSuccessOrder(selectedTimeslot);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  void rescheduleAppointment() {
    Get.toNamed('/consultation-date-picker',
        arguments: [selectedTimeslot.teacher, selectedTimeslot]);
  }
}
