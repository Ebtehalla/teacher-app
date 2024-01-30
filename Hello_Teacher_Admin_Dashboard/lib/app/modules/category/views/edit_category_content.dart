import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/controllers/category_controller.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';
import 'package:image_picker_web/image_picker_web.dart';

class EditCategoryContent extends StatelessWidget {
  final CategoryController controller;
  const EditCategoryContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 300,
      child: Obx(() => Column(
            children: [
              // ChooseImage(
              //   onImageGetChoose: (imageData) {
              //     controller.fileName = imageData.fileName;
              //     controller.imageFile = imageData.data;
              //     controller.updateSelectedImage();
              //   },
              //   selectedImageUrl: controller.editedCategory?.iconUrl,
              //   selectedImage: controller.selectedImage?.value,
              // ),
              AspectRatio(
                aspectRatio: 1.0, // Maintain aspect ratio (1.0 means square)
                child: controller.selectedImage?.value ??
                    Image.network(
                      controller.editedCategory!.iconUrl!,
                      fit: BoxFit
                          .scaleDown, // Preserve aspect ratio and fit inside
                    ),
              ),
              TextButton(
                  onPressed: () async {
                    final imageData = await ImagePickerWeb.getImageInfo;
                    controller.fileName = imageData?.fileName;
                    controller.imageFile = imageData?.data;
                    controller.updateSelectedImage();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload),
                      Text('Choose Category Image'),
                    ],
                  )),
              const SizedBox(
                height: defaultPadding,
              ),
              TextFormField(
                controller: controller.textEditingController,
                decoration: const InputDecoration(
                    hintText: "Category Name", prefixText: 'Name '),
                onChanged: (value) {
                  controller.newCategoryName = value;
                },
              )
            ],
          )),
    );
  }
}
