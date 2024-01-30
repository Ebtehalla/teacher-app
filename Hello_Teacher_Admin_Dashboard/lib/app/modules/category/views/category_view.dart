import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/views/add_category_content.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/views/detail_category_content.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/category/views/edit_category_content.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';
import 'package:hello_teacher_admin_dashboard/responsive.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Get.defaultDialog(
                    title: 'Add new Category',
                    content: AddCategoryContent(controller: controller),
                    onConfirm: () {
                      controller.addNewCategory();
                    },
                    onCancel: controller.cancelDialog);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: controller.obx(
            (listCategory) {
              return SizedBox(
                height: 720,
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Image'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Category Name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        listCategory!.length,
                        (index) => DataRow(cells: [
                              DataCell(InkWell(
                                onTap: () {
                                  controller.editedCategory =
                                      listCategory[index];
                                  Get.defaultDialog(
                                      title: 'Detail Image Carousel',
                                      content: DetailCategoryContent(
                                          controller: controller),
                                      onConfirm: () {
                                        Get.back();
                                      },
                                      textConfirm: 'Ok');
                                },
                                child: Image.network(
                                    listCategory[index].iconUrl ?? ''),
                              )),
                              DataCell(
                                  Text(listCategory[index].categoryName ?? '')),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        controller.selectedIndex = index;
                                        controller.setSelectedCategory(
                                            listCategory[index]);
                                        Get.defaultDialog(
                                            title: 'Edit Category',
                                            content: EditCategoryContent(
                                                controller: controller),
                                            onConfirm: () async {
                                              await controller.editCategory();
                                              Get.back();
                                              Fluttertoast.showToast(
                                                  msg: 'Success Edit Category',
                                                  timeInSecForIosWeb: 3);
                                            },
                                            onCancel: controller.cancelDialog);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: 'Delete Category',
                                            content: Text(
                                                'Are you sure you wanto delete ${listCategory[index].categoryName ?? ''} Category?'),
                                            onConfirm: () {
                                              controller.deleteCategory(
                                                  listCategory[index].id);
                                            },
                                            onCancel: () {});
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.info),
                                      onPressed: () {
                                        controller.setSelectedCategory(
                                            listCategory[index]);
                                        Get.defaultDialog(
                                          title: 'Category Detail',
                                          content: DetailCategoryContent(
                                              controller: controller),
                                          textConfirm: 'Close',
                                          onConfirm: () {
                                            Get.back();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ]))),
              );
            },
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
