import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/category_model.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/category_service.dart';
import 'package:halo_teacher/app/services/firebase_service.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class AddTeacherDetailController extends GetxController
    with StateMixin<List<CategoryModel>> {
  var formkey = GlobalKey<FormState>();
  var teacherName = ''.obs;
  var education = ''.obs;
  var shortBiography = ''.obs;
  CategoryModel? teacherCategory;
  Teacher? teacher = Get.arguments;
  var profilePicUrl = ''.obs;
  bool isEdit = false;
  @override
  void onInit() {
    super.onInit();
    if (teacher != null) {
      isEdit = true;
      profilePicUrl.value = teacher?.picture ?? '';
      teacherName.value = teacher!.name!;
      education.value = teacher?.education ?? '';
      shortBiography.value = teacher?.shortBiography ?? '';
      teacherCategory = teacher?.category;
      update();
    }
    print('user data : ' + UserService().currentUserFirebase!.uid);
  }

  void initCategory() async {
    var listCategory = await CategoryService().getListCategory();
    change(listCategory, status: RxStatus.success());
  }

  void updateProfilePic(File filePath) async {
    try {} catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      EasyLoading.dismiss();
    }
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    String imgUrl = await FirebaseService().uploadImage(filePath);
    Get.back();
    await UserService().updateProfileUrl(imgUrl);
  }

  void toEditProfilePic() async {
    // String? profileUrl = await Get.toNamed(Routes.);
    // if (profileUrl != null) {
    //   profilePicUrl.value = profileUrl;
    // }
    var profileUrl = await Get.toNamed(Routes.EDIT_IMAGE);
    if (profileUrl != null) {
      profilePicUrl.value = profileUrl;
    }
  }

  void saveTeacherData() async {
    if (profilePicUrl.value.isEmpty) {
      Fluttertoast.showToast(msg: 'Please choose your profile photo'.tr);
      return;
    }
    if (teacherCategory == null) {
      Fluttertoast.showToast(
          msg: 'Please choose Teacher Specialty or Category'.tr);
      return;
    }
    if (formkey.currentState!.validate() && teacherCategory != null) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      try {
        await TeacherService().saveTeacherData(
            teacherName: teacherName.value,
            education: education.value,
            shortBiography: shortBiography.value,
            pictureUrl: profilePicUrl.value,
            teacherCategory: teacherCategory!,
            isUpdate: isEdit);
        if (isEdit) {
          Get.back();
        } else {
          Get.offAllNamed(Routes.TEACHER_DASHBOARD);
        }
        EasyLoading.dismiss();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        EasyLoading.dismiss();
      }
    }
  }
}
