import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/widgets/empty_list.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/teacher_appointment_controller.dart';
import 'package:intl/intl.dart';

class TeacherAppointmentView extends GetView<TeacherAppointmentController> {
  const TeacherAppointmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointment'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: controller.obx(
            (listOrder) => ListView.builder(
              shrinkWrap: true,
              itemCount: listOrder!.length,
              itemBuilder: (builder, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(Routes.TEACHER_DETAIL_ORDER,
                          arguments: listOrder[index]);
                    },
                    leading: CircleAvatar(
                        backgroundImage:
                            listOrder[index].bookByWho!.photoUrl!.isNotEmpty
                                ? NetworkImage(
                                    listOrder[index].bookByWho!.photoUrl!)
                                : AssetImage('assets/images/user.png')
                                    as ImageProvider),
                    title: Text('Appointment with '.tr +
                        listOrder[index].bookByWho!.displayName!),
                    subtitle: Text(
                      'at '.tr +
                          DateFormat('EEEE, dd, MMMM')
                              .format(listOrder[index].timeSlot!),
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      children: [Icon(Icons.arrow_forward_ios)],
                    ),
                  ),
                );
              },
            ),
            onEmpty: Center(child: EmptyList(msg: 'no order'.tr)),
          ),
        ));
  }
}
