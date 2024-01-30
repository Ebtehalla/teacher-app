import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/models/settings_model.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/image_carousel/controllers/image_carousel_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/services/settings_service.dart';

class SettingsController extends GetxController with StateMixin<SettingsModel> {
  //TODO: Implement SettingsController

  final count = 0.obs;
  SettingsModel? settingsModel;
  List<String> tabBarTitle = ['Percentage', 'Carousel'];
  @override
  void onInit() async {
    super.onInit();
  }

  void initSettings() async {
    try {
      if (settingsModel == null) {
        settingsModel = await SettingsService().getSettings();
        change(settingsModel, status: RxStatus.success());
        Get.find<ImageCarouselController>().initImageCarousel();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void saveSettings(int percentage, int tax) async {
    try {
      EasyLoading.show();
      SettingsModel newSettings =
          SettingsModel(percentage: percentage, tax: tax);
      await SettingsService().saveSettings(newSettings);
      settingsModel = newSettings;
      change(settingsModel, status: RxStatus.success());
      Get.back();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
