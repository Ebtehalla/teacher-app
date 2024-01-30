import 'package:get/get.dart';
import 'package:halo_teacher/app/models/category_model.dart';
import 'package:halo_teacher/app/services/category_service.dart';

class CategoryController extends GetxController
    with StateMixin<List<CategoryModel>> {
  @override
  void onInit() {
    super.onInit();
    CategoryService().getListCategory().then((value) {
      change(value, status: RxStatus.success());
    }).catchError((err) {
      print('error : ' + err.toString());
      change([], status: RxStatus.error(err.toString()));
    });
  }
}
