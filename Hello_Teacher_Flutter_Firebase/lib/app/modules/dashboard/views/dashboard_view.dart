import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/appointment/views/appointment_view.dart';
import 'package:halo_teacher/app/modules/category/views/category_view.dart';
import 'package:halo_teacher/app/modules/home/views/home_view.dart';
import 'package:halo_teacher/app/modules/list_chat/views/list_chat_view.dart';
import 'package:halo_teacher/app/modules/profile/views/profile_view.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    CategoryView(),
    AppointmentView(),
    ListChatView(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Styles.primaryColor,
            unselectedItemColor: Styles.lightPrimaryColor,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Styles.primaryColor,
                  ),
                  label: "Home".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contacts,
                    color: Styles.primaryColor,
                  ),
                  label: "Teacher".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_camera_front,
                    color: Styles.primaryColor,
                  ),
                  label: "Appointment".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    color: Styles.primaryColor,
                  ),
                  label: "Chat".tr),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Styles.primaryColor,
                  ),
                  label: "Profile".tr),
            ],
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              controller.selectedIndex = index;
            },
          )),
      body: Obx(
        () => Center(
          child: IndexedStack(
              index: controller.selectedIndex, children: bodyContent),
        ),
      ),
    );
  }
}
