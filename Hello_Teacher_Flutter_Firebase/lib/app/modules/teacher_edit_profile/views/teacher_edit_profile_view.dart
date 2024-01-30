import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/teacher_edit_profile/views/widgets/edit_profile_tile.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/teacher_edit_profile_controller.dart';

class TeacherEditProfileView extends GetView<TeacherEditProfileController> {
  const TeacherEditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Account'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Container(
          child: GetX<TeacherEditProfileController>(
            init: Get.find<TeacherEditProfileController>(),
            builder: (controller) => Column(
              children: [
                EditProfileTile(
                  title: 'Username'.tr,
                  subtitle: controller.username.value,
                ),
                Divider(
                  height: 0,
                ),
                EditProfileTile(
                  title: 'Email'.tr,
                  subtitle: controller.email.value,
                  onTap: () {
                    controller.toUpdateEmail();
                  },
                ),
                Divider(
                  height: 0,
                ),
                EditProfileTile(
                  title: 'Password'.tr,
                  subtitle: controller.password,
                  onTap: () {
                    controller.toChangePassword();
                  },
                ),
                Obx(() => EditProfileTile(
                      title: 'Base Price'.tr,
                      subtitle: '$currencySign ${controller.basePrice.value}',
                      onTap: () {
                        controller.toChangeBasePrice();
                      },
                    )),
                EditProfileTile(
                  title: 'Account'.tr,
                  subtitle: 'Delete Account'.tr,
                  onTap: () {
                    controller.toDeleteAccount();
                  },
                  textAction: 'Delete'.tr,
                ),
              ],
            ),
          ),
        ));
  }
}
