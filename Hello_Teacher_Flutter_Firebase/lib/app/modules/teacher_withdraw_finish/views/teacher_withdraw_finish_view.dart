import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halo_teacher/app/modules/widgets/submit_button.dart';
import 'package:lottie/lottie.dart';

import '../controllers/teacher_withdraw_finish_controller.dart';

class TeacherWithdrawFinishView
    extends GetView<TeacherWithdrawFinishController> {
  const TeacherWithdrawFinishView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withraw Finish'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Lottie.asset(
                  'assets/animations/lottie_money_animation.json',
                  height: 250,
                  repeat: false,
                  controller: controller.animController,
                  onLoaded: (composition) {
                controller.animController.forward();
              }),
            ),
            Text(
              'Perfect, you have submitted a money withdrawal, we will immediately verify it, you will immediately get a notification when the withdrawal is verified'
                  .tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SubmitButton(
                onTap: () async {
                  await controller.ok();
                },
                text: 'OK')
          ],
        ),
      ),
    );
  }
}
