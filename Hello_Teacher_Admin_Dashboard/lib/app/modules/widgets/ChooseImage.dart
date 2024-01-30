import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ChooseImage extends StatelessWidget {
  final Function(MediaInfo imageInfo) onImageGetChoose;
  final Image? selectedImage;
  final String? selectedImageUrl;
  const ChooseImage(
      {super.key,
      required this.onImageGetChoose,
      this.selectedImage,
      this.selectedImageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final imageData = await ImagePickerWeb.getImageInfo;
        if (imageData != null) {
          onImageGetChoose(imageData);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white, width: 2), // Border around the form
          borderRadius:
              BorderRadius.circular(10), // Rounded corners for the border
          color: Colors.lightBlue[600], // Background color inside the border
        ),
        child: AspectRatio(
          aspectRatio: 1.0, // Maintain aspect ratio (1.0 means square)
          child: selectedImage ?? Image.asset('assets/images/image.png'),
        ),
      ),
    );
  }
}
