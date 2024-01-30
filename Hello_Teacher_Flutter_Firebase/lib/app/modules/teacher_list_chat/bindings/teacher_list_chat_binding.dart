import 'package:get/get.dart';

import '../controllers/teacher_list_chat_controller.dart';

class TeacherListChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherListChatController>(
      () => TeacherListChatController(),
    );
  }
}
