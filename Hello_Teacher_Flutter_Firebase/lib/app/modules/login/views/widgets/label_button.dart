import 'package:flutter/material.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

class LabelButton extends StatelessWidget {
  const LabelButton(
      {Key? key, required this.onTap, required this.title, this.subTitle = ''})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  color: Styles.primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
