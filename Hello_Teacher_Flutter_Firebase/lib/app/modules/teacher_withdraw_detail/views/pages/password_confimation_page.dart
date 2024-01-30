import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/teacher_withdraw_detail/controllers/teacher_withdraw_detail_controller.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

class PasswordConfirmationPage
    extends GetView<TeacherWithdrawDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Confim Password',
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.blue[400],
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                onChanged: (value) => controller.pass.value = value,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.requestWithdraw();
                  },
                  child: Text('Verify Password'))
            ],
          ),
        )));
  }
}
