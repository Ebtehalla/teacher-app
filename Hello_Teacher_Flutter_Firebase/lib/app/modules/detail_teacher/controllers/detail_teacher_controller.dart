import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/review_model.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/services/review_service.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:flutter_chat_ui/flutter_chat_ui_types.dart' as types;

class DetailTeacherController extends GetxController with StateMixin<Teacher> {
  Teacher selectedTeacher = Get.arguments;
  List<ReviewModel> listReview = [];
  @override
  void onInit() {
    super.onInit();
    ReviewService().getTeacherReview(teacher: selectedTeacher).then((value) {
      listReview = value;
      change(selectedTeacher, status: RxStatus.success());
    });
  }

  void toChatTeacher() async {
    String teacherUserId = await TeacherService().getUserId(selectedTeacher);
    if (teacherUserId.isEmpty) {
      Fluttertoast.showToast(msg: 'Teacher no longger exist'.tr);
      return;
    }
    final otherUser = types.User(
        id: teacherUserId,
        displayName: selectedTeacher.name,
        imageUrl: selectedTeacher.picture);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    Get.toNamed('/chat', arguments: [room, selectedTeacher]);
  }
}
