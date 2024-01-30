import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/auth_service.dart';
import 'package:halo_teacher/app/services/carousel_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final caoruselIndex = 0.obs;
  get getcaoruselIndex => caoruselIndex.value;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var userPicture = ''.obs;
  List<String?> listImageCarousel = [];

  @override
  void onInit() async {
    super.onInit();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    userPicture.value = userService.getProfilePicture();
    listImageCarousel = await CarouselService().getListCarouselUrl();
    print('jumlah image carousel : ${listImageCarousel.length}');
    update();
  }

  @override
  void onClose() {}
  void carouselChange(int index) {
    caoruselIndex.value = index;
  }

  void logout() async {
    authService.logout().then((value) => Get.toNamed(Routes.LOGIN));
  }

  void toTeacherCategory() {
    Get.find<DashboardController>().selectedIndex = 1;
  }

  void toTopRatedTeacher() {
    Get.toNamed(Routes.TOP_RATED_TEACHER);
  }

  void toSearchTeacher() {
    Get.toNamed(Routes.SEARCH_TEACHER);
  }
}
