import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key, this.imageUrl = ''});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imageUrl.isEmpty
          ? AssetImage('assets/images/user.png')
          : NetworkImage(imageUrl) as ImageProvider,
    );
  }
}
