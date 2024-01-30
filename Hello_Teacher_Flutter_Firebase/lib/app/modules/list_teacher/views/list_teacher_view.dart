import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/list_teacher/views/widgets/teacher_card.dart';
import 'package:halo_teacher/app/modules/widgets/empty_list.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';

import '../controllers/list_teacher_controller.dart';

class ListTeacherView extends GetView<ListTeacherController> {
  const ListTeacherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher".tr),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: controller.obx(
              (listTeacher) => ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: listTeacher!.length,
                itemBuilder: (context, index) {
                  return TeacherCard(
                      teacherName: listTeacher[index].name ?? '',
                      category: listTeacher[index].category?.categoryName ?? '',
                      basePrice: currencySign +
                          listTeacher[index].basePrice.toString(),
                      teacherPhotoUrl: listTeacher[index].picture ??
                          'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg',
                      education: listTeacher[index].education ?? '',
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_TEACHER,
                            arguments: listTeacher[index]);
                      });
                },
              ),
              onEmpty: Center(
                child:
                    EmptyList(msg: 'No Teacher Registered in this Category'.tr),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
