import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/widgets/SearchField.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

import '../controllers/teachers_controller.dart';

class TeachersView extends GetView<TeachersController> {
  const TeachersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: controller.obx(
        (listTeacher) {
          return SizedBox(
            height: 800,
            child: Column(
              children: [
                SearchField(
                  onQueryChange: (query) {
                    controller.searchQuery = query;
                  },
                  searchQuery: controller.searchQuery,
                  onSearch: () {
                    controller.searchteachers(controller.searchQuery);
                  },
                  onClear: () {
                    controller.searchteachers('');
                  },
                  textEditingController: controller.searchController,
                ),
                SizedBox(
                  height: 720,
                  child: PaginatedDataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Name'),
                        size: ColumnSize.M,
                      ),
                      DataColumn(
                        label: Text('Email'),
                      ),
                      DataColumn2(
                          label: Text('Created At'), size: ColumnSize.L),
                      DataColumn(
                        label: Text('Category'),
                      ),
                      DataColumn2(label: Text('Balance'), size: ColumnSize.S),
                      DataColumn(
                        label: Text('Base Price'),
                      ),
                      DataColumn(
                        label: Text('Status'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    source: controller.teacherTableSource,
                  ),
                ),
              ],
            ),
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
