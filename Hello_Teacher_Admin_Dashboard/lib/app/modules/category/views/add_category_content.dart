import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/controllers/category_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/widgets/ChooseImage.dart';

import '../../../../constants.dart';

class AddCategoryContent extends StatelessWidget {
  final CategoryController controller;
  const AddCategoryContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 500,
          width: 300,
          child: Column(
            children: [
              ChooseImage(
                onImageGetChoose: (imageData) {
                  controller.fileName = imageData.fileName;
                  controller.imageFile = imageData.data;
                  controller.updateSelectedImage();
                },
                selectedImage: controller.selectedImage?.value,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              TextFormField(
                controller: controller.textEditingController,
                decoration: const InputDecoration(
                    hintText: "Category Name", border: OutlineInputBorder()),
                onChanged: (value) {
                  controller.newCategoryName = value;
                },
              )
            ],
          ),
        ));
  }
}
