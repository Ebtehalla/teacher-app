import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/utils/timeformat.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

import '../controllers/withdrawal_controller.dart';

class WithdrawalView extends GetView<WithdrawalController> {
  const WithdrawalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: controller.obx(
        (listWithdrawalRequest) {
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
                  DataColumn2(label: Text('Amount'), size: ColumnSize.S),
                  DataColumn2(label: Text('Admin Fee'), size: ColumnSize.S),
                  DataColumn2(label: Text('Tax'), size: ColumnSize.S),
                  DataColumn2(
                      label: Text('Total Withdraw'), size: ColumnSize.S),
                  DataColumn2(
                    label: Text('Email'),
                  ),
                  DataColumn2(label: Text('Method'), size: ColumnSize.S),
                  DataColumn2(label: Text('Name'), size: ColumnSize.M),
                  DataColumn2(
                    label: Text('User ID'),
                  ),
                  DataColumn2(
                    label: Text('Status'),
                  ),
                  DataColumn2(
                    label: Text('Action'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    listWithdrawalRequest!.length,
                    (index) => DataRow(cells: [
                          DataCell(Text(TimeFormat().formatDate(
                              listWithdrawalRequest[index].createdAt))),
                          DataCell(Text(currencySign +
                              listWithdrawalRequest[index].amount!.toString())),
                          DataCell(Text(currencySign +
                              listWithdrawalRequest[index]
                                  .adminFee
                                  .toString())),
                          DataCell(Text(currencySign +
                              listWithdrawalRequest[index].tax.toString())),
                          DataCell(Text(currencySign +
                              listWithdrawalRequest[index]
                                  .totalWithdraw
                                  .toString())),
                          DataCell(Text(listWithdrawalRequest[index]
                              .withdrawMethod!
                              .email
                              .toString())),
                          DataCell(Text(listWithdrawalRequest[index]
                              .withdrawMethod!
                              .method
                              .toString())),
                          DataCell(Text(listWithdrawalRequest[index]
                              .withdrawMethod!
                              .name
                              .toString())),
                          DataCell(Text(listWithdrawalRequest[index]
                              .withdrawMethod!
                              .userId
                              .toString())),
                          DataCell(
                              Text(listWithdrawalRequest[index].status ?? '')),
                          DataCell(
                            listWithdrawalRequest[index].status == 'completed'
                                ? SizedBox()
                                : IconButton(
                                    icon: const Icon(Icons.done),
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: 'Mark Withdraw Complete',
                                          content: const Text(
                                              'Are you sure you want to mark this withdrawal as completed? Please ensure that you have sent the teacher the money.'),
                                          onConfirm: () {
                                            controller.markWithdrawlCompleted(
                                                listWithdrawalRequest[index]
                                                    .id!);
                                          },
                                          textConfirm: 'Mark as Complete',
                                          textCancel: 'Cancel');
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
    );
  }
}
