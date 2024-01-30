import 'package:halo_teacher/app/models/review_model.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';

class TeacherDashboardModel {
  TeacherDashboardModel({this.balance, this.listReview, this.listAppointment});

  int? balance;
  List<TimeSlot>? listAppointment;
  List<ReviewModel>? listReview;
}
