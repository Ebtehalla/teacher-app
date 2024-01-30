import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class EditImageController extends GetxController {
  void updateProfilePic(File filePath) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var updatedUrl = await UserService().updateProfilePic(filePath);
      Get.back(result: updatedUrl);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
