import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/teacher_appointment/controllers/teacher_appointment_controller.dart';
import 'package:halo_teacher/app/modules/teacher_calendar/controllers/teacher_calendar_controller.dart';
import 'package:halo_teacher/app/services/local_notification_service.dart';
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class TeacherDashboardController extends GetxController {
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;
  NotificationService notificationService = Get.find<NotificationService>();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    EasyLoading.show();
    await UserService().getUserModel();
    await LocalNotificationService().requestPermission();
    await UserService()
        .updateUserToken(await notificationService.getNotificationToken());
    notificationService.listenNotification();
    EasyLoading.dismiss();
  }

  void initTabAppointment() {
    Get.find<TeacherCalendarController>().initTeacherSchedule();
  }

  void initTabOrder() {
    Get.find<TeacherAppointmentController>().initOrderedTimeSlot();
  }

  void activateTabAppointment() {
    initTabAppointment();
    updateTabSelection(1);
  }

  void activateTabOrder() {
    initTabOrder();
    updateTabSelection(2);
  }

  void updateTabSelection(int index) {
    selectedIndex = index;
  }
}
