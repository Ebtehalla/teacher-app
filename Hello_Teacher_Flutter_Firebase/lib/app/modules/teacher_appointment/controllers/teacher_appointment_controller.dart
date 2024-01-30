import 'package:get/get.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/services/timeslot_service.dart';

class TeacherAppointmentController extends GetxController
    with StateMixin<List<TimeSlot>> {
  final isTabOpen = false;
  void initOrderedTimeSlot() {
    change([], status: RxStatus.loading());
    TimeSlotService().getOrderedTimeSlot().then((value) {
      if (value.isEmpty) {
        change(value, status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
    }).catchError((err) {
      change([], status: RxStatus.error());
    });
  }
}
