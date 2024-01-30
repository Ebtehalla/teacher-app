import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyList extends StatelessWidget {
  EmptyList(
      {Key? key, required this.msg, this.onRefreshClick, this.refreshText})
      : super(key: key);

  final String msg;
  final VoidCallback? onRefreshClick;
  String? refreshText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            msg,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 15),
          ),
          refreshText == null
              ? ElevatedButton(
                  onPressed: onRefreshClick, child: Text('Refresh'.tr))
              : ElevatedButton(
                  onPressed: onRefreshClick,
                  child: Text(refreshText.toString()))
        ],
      ),
    );
  }
}
