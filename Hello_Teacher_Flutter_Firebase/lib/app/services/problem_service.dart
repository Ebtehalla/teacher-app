import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';

class ProblemService {
  Future sendProblem(String myProblem, TimeSlot timeSlot) async {
    try {
      await FirebaseFirestore.instance
          .collection('Problem')
          .add({'problem': myProblem, 'timeSlot': timeSlot.id});
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }
}
