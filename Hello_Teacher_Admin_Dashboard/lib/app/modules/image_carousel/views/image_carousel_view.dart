import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';
import 'package:hello_teacher_admin_dashboard/responsive.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../controllers/image_carousel_controller.dart';

class ImageCarouselView extends GetView<ImageCarouselController> {
  const ImageCarouselView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Image Carousel",
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
                      content: Column(
                        children: [
                          TextButton(
                              onPressed: () async {
                                final imageData =
                                    await ImagePickerWeb.getImageInfo;
                                controller.fileName = imageData?.fileName;
                                controller.imageFile = imageData?.data;
                              },
                              child: const Text('Choose Carousel Image')),
                        ],
                      ),
                      onConfirm: () {
                        controller.addNewCarouselImage();
                        Get.back();
                      });
                },
                icon: Icon(Icons.add),
                label: Text("Add New"),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          controller.obx(
            (listCategory) {
              return SizedBox(
                height: 500,
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('File Name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        listCategory!.length,
                        (index) => DataRow(cells: [
                              DataCell(Text(listCategory[index].fileName!)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'Delete Image Carousel',
                                        content: Text(
                                            'Are you sure you wanto delete ${listCategory[index].fileName!} Image Carousel?'),
                                        onConfirm: () {
                                          controller.deleteImageCarousel(
                                              listCategory[index].id!);
                                          Get.back();
                                        },
                                        onCancel: () {});
                                  },
                                ),
                              )
                            ]))),
              );
            },
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
