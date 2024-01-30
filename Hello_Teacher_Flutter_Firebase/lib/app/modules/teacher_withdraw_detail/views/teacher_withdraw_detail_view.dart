import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halo_teacher/app/modules/widgets/submit_button.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/teacher_withdraw_detail_controller.dart';

class TeacherWithdrawDetailView
    extends GetView<TeacherWithdrawDetailController> {
  const TeacherWithdrawDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confim Withdaw'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue[400],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                  'Please make sure the data below is correct, we will make a withdrawal after you confirm it'
                      .tr,
                  style: GoogleFonts.nunito(
                      fontSize: 13, color: Styles.greyTextColor)),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 240,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x10000000),
                          blurRadius: 10,
                          spreadRadius: 4,
                          offset: Offset(0.0, 8.0))
                    ],
                  ),
                  alignment: Alignment.topCenter,
                  child: GetBuilder<TeacherWithdrawDetailController>(
                    builder: (_) {
                      return Table(
                        children: [
                          TableRow(children: [
                            SizedBox(
                                height: 30, child: Text('Withdraw Method'.tr)),
                            SizedBox(height: 30, child: Text(': Paypal')),
                          ]),
                          TableRow(children: [
                            SizedBox(height: 30, child: Text('Name')),
                            SizedBox(
                                height: 30,
                                child: Text(
                                    ': ${controller.withdrawMethod.name!}')),
                          ]),
                          TableRow(children: [
                            SizedBox(height: 40, child: Text('Email'.tr)),
                            SizedBox(
                              height: 40,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                    ': ${controller.withdrawMethod.email!}'),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                                height: 30, child: Text('Amount Withdraw'.tr)),
                            SizedBox(
                              height: 30,
                              child: Text(
                                ': $currencySign${controller.amount}',
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(height: 30, child: Text('Admin Fee'.tr)),
                            SizedBox(
                              height: 30,
                              child: controller.percentageCut != null
                                  ? Text(
                                      ': (' +
                                          currencySign +
                                          controller.percentageCut!
                                              .toStringAsFixed(2) +
                                          ")" +
                                          (controller.withdrawSettingsDetail
                                                      ?.percentage ??
                                                  0)
                                              .toString() +
                                          '%',
                                    )
                                  : Text(''),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(height: 30, child: Text('Tax'.tr)),
                            SizedBox(
                              height: 30,
                              child: controller.percentageTaxCut != null
                                  ? Text(
                                      ': (' +
                                          currencySign +
                                          controller.percentageTaxCut!
                                              .toStringAsFixed(2) +
                                          ")" +
                                          (controller.withdrawSettingsDetail
                                                      ?.tax ??
                                                  0)
                                              .toString() +
                                          '%',
                                    )
                                  : Text(''),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                                height: 30, child: Text('Total Withdraw'.tr)),
                            SizedBox(
                              height: 30,
                              child: controller.total != null
                                  ? Text(
                                      ': ${controller.total!.toStringAsFixed(2)}')
                                  : Text(''),
                            ),
                          ]),
                        ],
                      );
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              SubmitButton(
                  onTap: () {
                    controller.toPasswordConfirmation();
                  },
                  text: 'Withdraw Now'.tr)
            ],
          ),
        ),
      ),
    );
  }
}
