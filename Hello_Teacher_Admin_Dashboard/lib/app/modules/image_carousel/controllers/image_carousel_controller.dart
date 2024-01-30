import 'dart:typed_data';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/models/image_carousel_model.dart';
import 'package:hello_teacher_admin_dashboard/app/services/image_carousel_service.dart';
import 'package:hello_teacher_admin_dashboard/app/services/image_service.dart';

class ImageCarouselController extends GetxController
    with StateMixin<List<ImageCarouselModel>> {
  List<ImageCarouselModel> listImageCarousel = [];

  Uint8List? imageFile;
  String? fileName;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future initImageCarousel() async {
    try {
      listImageCarousel = await ImageCarouselService().getImageCarousel();
      change(listImageCarousel, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteImageCarousel(String imageCarouselId) async {
    try {
      await ImageCarouselService().removeImageCarousel(imageCarouselId);
      listImageCarousel.removeWhere((element) => element.id == imageCarouselId);
      change(listImageCarousel, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addNewCarouselImage() async {
    try {
      EasyLoading.show();
      if (imageFile != null) {
        String imageUrl = await ImageService().uploadImageHtml(imageFile!);
        ImageCarouselModel newImageCarousel = ImageCarouselModel(
            imageUrl: imageUrl, createdAt: DateTime.now(), fileName: fileName);
        ImageCarouselModel newImageCarouselWithId =
            await ImageCarouselService().addImageCarousel(newImageCarousel);
        listImageCarousel.add(newImageCarouselWithId);
        change(listImageCarousel, status: RxStatus.success());
      }
    } catch (e) {
      return Future.error(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
