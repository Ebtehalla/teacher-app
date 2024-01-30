import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:universal_html/html.dart';

class ImageService {
  Future<String> uploadImageHtml(Uint8List htmlFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');
      final uploadTask =
          ref.putData(htmlFile, SettableMetadata(contentType: 'image/jpeg'));

      final snapshot = await uploadTask.whenComplete(() {});
      final fileUrl = await snapshot.ref.getDownloadURL();

      return fileUrl;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String?> uploadImage(String? imagePath) async {
    if (imagePath == null) {
      return null;
    }

    Uint8List imageData = await XFile(imagePath).readAsBytes();

    try {
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now().millisecondsSinceEpoch}')
          .putData(
            imageData,
            SettableMetadata(contentType: 'image/jpeg'),
          );

      String url = await upload.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading image: ${e.toString()}');
      return null;
    }
  }

  Future<void> removeImage(String imageUrl) async {
    try {
      final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
    } catch (e) {
      print("Error removing image: $e");
    }
  }
}
