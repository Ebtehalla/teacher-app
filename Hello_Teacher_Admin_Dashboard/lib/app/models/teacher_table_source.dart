import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/models/teacher_model.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/teachers/controllers/teachers_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/teachers/views/detail_teacher_content.dart';

class TeacherTableSource extends DataTableSource {
  late final List<TeacherModel> listTeacher;
  late TeachersController teacherController;
  TeacherTableSource(this.listTeacher) {
    teacherController = Get.find<TeachersController>();
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(listTeacher[index].name!)),
      DataCell(Text(listTeacher[index].email!)),
      DataCell(Text(listTeacher[index].createdAt.toString())),
      DataCell(Text(listTeacher[index].category?.categoryName ?? '')),
      DataCell(Text(listTeacher[index].balance.toString())),
      DataCell(Text(listTeacher[index].basePrice.toString())),
      DataCell(Text(listTeacher[index].accountStatus.toString())),
      DataCell(
        Row(
          children: [
            listTeacher[index].accountStatus == 'active'
                ? IconButton(
                    icon: const Icon(Icons.block),
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Banned Account",
                          content: const Text(
                            'Are you sure you want to banned this teacher account? This teacher will be not visible to all students',
                            textAlign: TextAlign.center,
                          ),
                          textCancel: 'Cancel',
                          textConfirm: 'Banned Teacher',
                          onConfirm: () {
                            Get.back();
                            teacherController
                                .dissableTeacher(listTeacher[index].id);
                          });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.done),
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Activate Account",
                          content: const Text(
                            'Are you sure 7you want to activate this teacher account? This teacher will be visible to all students and can receive timeslot orders',
                            textAlign: TextAlign.center,
                          ),
                          textCancel: 'Cancel',
                          textConfirm: 'Activate Teacher',
                          onConfirm: () {
                            Get.back();
                            teacherController
                                .activateTeacher(listTeacher[index].id);
                          });
                    },
                  ),
            (listTeacher[index].topRated == null ||
                    listTeacher[index].topRated == false)
                ? IconButton(
                    icon: const Icon(Icons.star_border_purple500_outlined),
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Set Top Rated Teacher",
                          content: const Text(
                            'Set this Teacher as a top rated teacher, this teacher will be promoted on the client\'s home page',
                            textAlign: TextAlign.center,
                          ),
                          textCancel: 'Cancel',
                          textConfirm: 'Set Top Rated',
                          onConfirm: () {
                            Get.back();
                            teacherController
                                .addToTopRatedTeacher(listTeacher[index].id);
                          });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Remove Top Rated Teacher",
                          content: const Text(
                            'Remove Top Rated Teacher',
                            textAlign: TextAlign.center,
                          ),
                          textCancel: 'Cancel',
                          textConfirm: 'Remove Top Rated Teacher',
                          onConfirm: () {
                            Get.back();
                            teacherController.removeTeacherFromTopRated(
                                listTeacher[index].id);
                          });
                    },
                  ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                teacherController.selectedTeacher = listTeacher[index];
                Get.defaultDialog(
                    title: "Detail Teacher",
                    content: DetailTeacher(controller: teacherController),
                    textCancel: 'Cancel',
                    textConfirm: 'Ok',
                    onConfirm: () {
                      Get.back();
                    });
              },
            ),
          ],
        ),
      )
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => listTeacher.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
