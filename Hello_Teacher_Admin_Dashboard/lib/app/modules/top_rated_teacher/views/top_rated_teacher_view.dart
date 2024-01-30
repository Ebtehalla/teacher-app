import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

import '../controllers/top_rated_teacher_controller.dart';

class TopRatedTeacherView extends GetView<TopRatedTeacherController> {
  const TopRatedTeacherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top Rated Teacher",
              style: Theme.of(context).textTheme.subtitle1,
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
            (listTeacher) {
              return SizedBox(
                height: 720,
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Name'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                          label: Text('Created At'), size: ColumnSize.L),
                      DataColumn2(
                          label: Text('Last Updated'), size: ColumnSize.L),
                      DataColumn(
                        label: Text('Category'),
                      ),
                      DataColumn2(label: Text('Balance'), size: ColumnSize.S),
                      DataColumn(
                        label: Text('Base Price'),
                      ),
                      DataColumn(
                        label: Text('Biography'),
                      ),
                      DataColumn(
                        label: Text('Education'),
                      ),
                      DataColumn(
                        label: Text('Status'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        listTeacher!.length,
                        (index) => DataRow(cells: [
                              // DataCell(Image.network(
                              //   listTeacher[index].TeacherPicture!,
                              //   height: 20,
                              // )),
                              DataCell(Text(listTeacher[index].name ?? '')),
                              DataCell(Text(
                                  listTeacher[index].createdAt.toString())),
                              DataCell(Text(
                                  listTeacher[index].updatedAt.toString())),
                              DataCell(Text(
                                  listTeacher[index].category?.categoryName ??
                                      '')),
                              DataCell(
                                  Text(listTeacher[index].balance.toString())),
                              DataCell(Text(
                                  listTeacher[index].basePrice.toString())),
                              DataCell(Text(listTeacher[index]
                                  .shortBiography
                                  .toString())),
                              DataCell(Text(
                                  listTeacher[index].education.toString())),
                              DataCell(Text(
                                  listTeacher[index].accountStatus.toString())),
                              DataCell(
                                Row(
                                  children: [
                                    (listTeacher[index].topRated == null ||
                                            listTeacher[index].topRated ==
                                                false)
                                        ? IconButton(
                                            icon: const Icon(Icons
                                                .star_border_purple500_outlined),
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title:
                                                      "Set Top Rated Teacher",
                                                  content: const Text(
                                                    'Set this Teacher as a top rated Teacher, this Teacher will be promoted on the client\'s home page',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  textCancel: 'Cancel',
                                                  textConfirm: 'Set Top Rated',
                                                  onConfirm: () {
                                                    Get.back();
                                                    controller
                                                        .addToTopRatedTeacher(
                                                            listTeacher[index]
                                                                .id);
                                                  });
                                            },
                                          )
                                        : IconButton(
                                            icon: const Icon(Icons.star),
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title:
                                                      "Remove Top Rated Teacher",
                                                  content: const Text(
                                                    'Remove Top Rated Teacher',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  textCancel: 'Cancel',
                                                  textConfirm:
                                                      'Remove Top Rated Teacher',
                                                  onConfirm: () {
                                                    Get.back();
                                                    controller
                                                        .removeTeacherFromTopRated(
                                                            listTeacher[index]
                                                                .id!);
                                                  });
                                            },
                                          )
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
