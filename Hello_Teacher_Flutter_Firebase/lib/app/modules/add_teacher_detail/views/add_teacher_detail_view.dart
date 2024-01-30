import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/add_teacher_detail/views/pages/choose_category_page.dart';
import 'package:halo_teacher/app/modules/profile/controllers/profile_controller.dart';
import 'package:halo_teacher/app/modules/profile/views/widgets/display_image_widget.dart';
import 'package:halo_teacher/app/modules/widgets/submit_button.dart';

import '../controllers/add_teacher_detail_controller.dart';

class AddTeacherDetailView extends GetView<AddTeacherDetailController> {
  const AddTeacherDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher Information'.tr),
        centerTitle: true,
        actions: [
          controller.isEdit == false
              ? PopupMenuButton(
                  icon: Icon(
                      Icons.menu), //don't specify icon if you want 3 dot menu
                  color: Colors.blue,
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onSelected: (item) {
                    ProfileController().logout();
                  },
                )
              : SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formkey,
          child: GetX<AddTeacherDetailController>(
            builder: (controller) => Column(
              children: [
                DisplayImage(
                    imagePath: controller.profilePicUrl.value,
                    onPressed: () {
                      controller.toEditProfilePic();
                    }),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  validator: ((value) {
                    if (value!.length < 3) {
                      return 'Name must be more than two characters'.tr;
                    } else {
                      return null;
                    }
                  }),
                  initialValue: controller.teacher == null
                      ? ''
                      : controller.teacherName.value,
                  onSaved: (name) {
                    controller.teacherName.value = name!;
                  },
                  decoration: InputDecoration(
                      hintText: controller.teacher == null
                          ? 'Teacher Name e.g : Alex'.tr
                          : '',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  initialValue: controller.teacher == null
                      ? null
                      : controller.education.value,
                  onSaved: (hospital) {
                    controller.education.value = hospital!;
                  },
                  decoration: InputDecoration(
                      hintText:
                          controller.teacher == null ? 'current job'.tr : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  onSaved: (shortBiography) {
                    controller.shortBiography.value = shortBiography!;
                  },
                  initialValue: controller.teacher == null
                      ? null
                      : controller.shortBiography.value,
                  decoration: InputDecoration(
                      hintText: controller.teacher == null
                          ? 'Short Biography'.tr
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    Get.to(() => ChooseCategoryPage());
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                          child: Text(controller.teacherCategory == null
                              ? 'Chose Teacher Category'.tr
                              : controller.teacherCategory!.categoryName!)),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                ),
                SubmitButton(
                    onTap: () {
                      controller.saveTeacherData();
                    },
                    text: 'Save'.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
