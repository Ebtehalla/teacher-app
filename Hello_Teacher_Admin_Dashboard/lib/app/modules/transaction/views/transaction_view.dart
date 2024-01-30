import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/utils/timeformat.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: controller.obx(
        (listTransaction) {
          return SizedBox(
            height: 720,
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(
                  label: Text('Created At'),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text('Updated At'),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Type'),
                ),
                DataColumn(
                  label: Text('Status'),
                ),
                DataColumn(
                  label: Text('Amount'),
                ),
              ],
              rows: List<DataRow>.generate(
                listTransaction!.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(TimeFormat()
                        .formatDate(listTransaction[index].createdAt))),
                    DataCell(Text(TimeFormat()
                        .formatDate(listTransaction[index].updatedAt))),
                    DataCell(Text(listTransaction[index].createdAt.toString())),
                    DataCell(Text(listTransaction[index].type.toString())),
                    DataCell(Text(currencySign +
                        listTransaction[index].amount.toString())),
                  ],
                ),
              ),
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
