import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';
import 'package:flutter_chat_ui/flutter_chat_ui_types.dart' as types;
import '../models/teacher_model.dart';

class ChatService {
  Future<Teacher> getTeacherByUserId(String uid) async {
    try {
      var user = await UserService().getUserModelById(uid);
      var teacher = await TeacherService().getTeacherDetail(user!.teacherId!);
      return teacher;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  ///TODO need to make it more clean
  Future<types.Room?> getRoomById(String roomId) async {
    try {
      var roomRef = await FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .get();
      var roomDataFirebase = roomRef.data();
      if (roomDataFirebase == null) return null;
      DateTime createdAt =
          (roomDataFirebase['createdAt'] as Timestamp).toDate();
      DateTime updatedAt =
          (roomDataFirebase['updatedAt'] as Timestamp).toDate();
      List<types.User> listUser = (roomDataFirebase['userIds'] as List<dynamic>)
          .map((e) => types.User(id: e))
          .toList();
      types.Room roomData = types.Room(
          id: roomId,
          type: types.RoomType.direct,
          users: listUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
          name: roomDataFirebase['name'],
          imageUrl: roomDataFirebase['imageUrl']);

      return roomData;
    } catch (e) {
      return Future.error(e);
    }
  }
}
