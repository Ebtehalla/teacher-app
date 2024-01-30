import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halo_teacher/app/models/teacher_dashboard_model.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/review_service.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/timeslot_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';

class TeacherHomeController extends GetxController
    with StateMixin<TeacherDashboardModel> {
  //TODO: Implement TeacherHomeController

  final username = ''.obs;
  final profilePic = ''.obs;
  TeacherDashboardModel dashboardModel = TeacherDashboardModel();

  @override
  void onReady() async {
    super.onReady();
    var userModel = await UserService().getUserModel();
    if (userModel?.role == Roles.user) {
      Fluttertoast.showToast(
          msg:
              'Your account role is user, not teacher please register another account as Teacher'
                  .tr);
      Get.offAllNamed(Routes.DASHBOARD);
      return;
    }
    var teacher = await TeacherService.getCurrentTeacher(forceGet: true);
    if (teacher == null) {
      if (await UserService().checkIfUserExist() == false) {
        AuthService().logout();
        return Get.offAllNamed(Routes.LOGIN);
      } else {
        return Get.offNamed(Routes.ADD_TEACHER_DETAIL);
      }
    }
    username.value = userModel?.displayName ?? '';
    profilePic.value = userModel?.photoUrl ?? '';
    await getListAppointment();
    await getListReview(teacher);
    getBalance();
  }

//Check whether, user is already set his detail teacher
  bool checkDetailTeacher() {
    bool? check = GetStorage().read(checkTeacherDetail);
    if (check == null || !check) return false;
    return true;
  }

  getListAppointment() async {
    try {
      dashboardModel.listAppointment =
          await TimeSlotService().getOrderedTimeSlot(limit: 5);
    } catch (err) {
      printError(info: err.toString());
    }
  }

  getListReview(Teacher teacher) async {
    try {
      dashboardModel.listReview = await ReviewService().getTeacherReview(
        teacher: teacher,
      );
    } catch (err) {
      printError(info: err.toString());
    }
  }

  getBalance() async {
    var currentTeacher = await TeacherService.getCurrentTeacher();
    dashboardModel.balance = currentTeacher?.balance ?? 0;
    change(dashboardModel, status: RxStatus.success());
  }
}
