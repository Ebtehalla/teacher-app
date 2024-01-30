import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

class VideoCallButton extends StatelessWidget {
  const VideoCallButton(
      {super.key, required this.onTap, required this.text, this.active = true});
  final VoidCallback onTap;
  final String text;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: active ? onTap : null,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: active == true
                  ? [Styles.lightPrimaryColor, Styles.primaryColor]
                  : [Colors.grey, Colors.grey],
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_call_rounded,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
