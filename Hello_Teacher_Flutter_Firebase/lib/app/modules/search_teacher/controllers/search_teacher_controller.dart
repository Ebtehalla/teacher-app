import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';

class SearchTeacherController extends GetxController {
  Rx<Teacher> teacher = Teacher(id: '').obs;
}
