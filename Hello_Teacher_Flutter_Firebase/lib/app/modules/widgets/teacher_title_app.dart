import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/styles/styles.dart';

class TeacherTitleApp extends StatelessWidget {
  const TeacherTitleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/ic_launcher.png',
          width: 45,
          height: 45,
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Teacher'.tr,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Styles.primaryColor),
              children: [
                TextSpan(
                  text: ' App'.tr,
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ]),
        ),
      ],
    );
  }
}
