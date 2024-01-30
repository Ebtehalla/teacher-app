import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:halo_teacher/app/services/timeslot_service.dart';
import 'package:halo_teacher/app/services/videocall_service.dart';

class TeacherDetailOrderController extends GetxController {
  TimeSlot orderedTimeslot = Get.arguments;
  var database = FirebaseDatabase.instance.ref();
  NotificationService notificationService = Get.find<NotificationService>();
  var active = true.obs;
  bool isReschedule = false;
  @override
  void onInit() async {
    super.onInit();
    if (orderedTimeslot.status == 'refund') active.value = false;
    if (orderedTimeslot.pastTimeSlot != null) isReschedule = true;
  }

  @override
  void onClose() {}
  void videoCall() async {
    //
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var token = await VideoCallService().getAgoraToken(orderedTimeslot.id!);
      final roomData = <String, dynamic>{
        'room': orderedTimeslot.id,
        'token': token,
        'timestamp': Timestamp.fromDate(DateTime.now())
      };
      await VideoCallService().createRoom(orderedTimeslot.id!, roomData);
      EasyLoading.dismiss();
      Get.toNamed(
        '/video-call',
        arguments: [
          {
            'token': token,
            'room': orderedTimeslot.id,
            'timeSlot': orderedTimeslot,
          }
        ],
      );
    } catch (e) {
      printError(info: e.toString());
      Fluttertoast.showToast(msg: e.toString());
      EasyLoading.dismiss();
    }
  }

  void cancelAppointment() async {
    try {
      EasyLoading.show();
      await TimeSlotService().cancelAppointment(orderedTimeslot);
      active.value = false;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
