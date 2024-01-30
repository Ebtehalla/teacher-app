import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/teacher_appointment/views/teacher_appointment_view.dart';
import 'package:halo_teacher/app/modules/teacher_calendar/views/teacher_calendar_view.dart';
import 'package:halo_teacher/app/modules/teacher_home/views/teacher_home_view.dart';
import 'package:halo_teacher/app/modules/teacher_list_chat/views/teacher_list_chat_view.dart';
import 'package:halo_teacher/app/modules/teacher_profile/views/teacher_profile_view.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/teacher_dashboard_controller.dart';

class TeacherDashboardView extends GetView<TeacherDashboardController> {
  final List<Widget> bodyContent = [
    TeacherHomeView(),
    TeacherCalendarView(),
    TeacherAppointmentView(),
    TeacherListChatView(),
    TeacherProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Center(
            child: IndexedStack(
                index: controller.selectedIndex, children: bodyContent),
          )),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    controller.updateTabSelection(0);
                  },
                  iconSize: 27,
                  icon: Icon(
                    Icons.home,
                    //darken the icon if it is selected or else give it a different color
                    color: controller.selectedIndex == 0
                        ? Styles.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.activateTabAppointment();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.calendar_today,
                    color: controller.selectedIndex == 1
                        ? Styles.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(2);
                    controller.initTabOrder();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: controller.selectedIndex == 2
                        ? Styles.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(3);
                    //controller.initTabOrder();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.chat,
                    color: controller.selectedIndex == 3
                        ? Styles.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(4);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.person,
                    color: controller.selectedIndex == 4
                        ? Styles.primaryColor
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
