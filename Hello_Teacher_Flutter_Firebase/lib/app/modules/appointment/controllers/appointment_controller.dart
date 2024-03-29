import 'package:get/get.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/services/timeslot_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class AppointmentController extends GetxController
    with StateMixin<List<TimeSlot>> {
  final count = 0.obs;
  final TimeSlotService _appointmentService = Get.find();
  UserService userService = Get.find();
  @override
  void onInit() async {
    super.onInit();
    getListAppointment();
  }

  @override
  void onClose() {}

  Future<void> getListAppointment() async {
    try {
      var listOrderedTimeslot = await _appointmentService
          .getListAppointment(userService.currentUserFirebase!);
      if (listOrderedTimeslot.isEmpty) {
        return change([], status: RxStatus.empty());
      }
      change(listOrderedTimeslot, status: RxStatus.success());
    } catch (err) {
      change([], status: RxStatus.error(err.toString()));
    }
  }
}
