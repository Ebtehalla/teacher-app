import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/add_teacher_detail/controllers/add_teacher_detail_controller.dart';
import 'package:halo_teacher/app/utils/search/search_category.dart';

class ChooseCategoryPage extends GetView<AddTeacherDetailController> {
  const ChooseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Category'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          controller.obx(
            (category) => IconButton(
              onPressed: () async {
                controller.teacherCategory = await showSearch(
                  context: context,
                  delegate: SearchCategoryDelegate(
                      teacherCategory: category!,
                      teacherCategorySugestion: category),
                );
                Get.back();
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: controller.obx(
        (category) => Container(
          child: ListView.builder(
            itemCount: category!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(category[index].categoryName!),
                onTap: () {
                  controller.teacherCategory = category[index];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
