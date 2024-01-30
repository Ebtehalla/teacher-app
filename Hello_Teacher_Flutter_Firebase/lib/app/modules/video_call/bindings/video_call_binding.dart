import 'package:get/get.dart';
import 'package:halo_teacher/app/services/videocall_service.dart';

import '../controllers/video_call_controller.dart';

class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(
      () => VideoCallController(),
    );
    Get.put(VideoCallService());
  }
}
