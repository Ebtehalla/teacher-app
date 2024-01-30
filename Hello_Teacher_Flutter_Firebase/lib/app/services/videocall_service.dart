import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';

typedef RoomAvailableCallBack = void Function(dynamic data);
typedef RemoteCandidateCallBack = void Function(
    dynamic candidate, dynamic sdpMid, dynamic sdpMLineIndex);

class VideoCallService {
  RoomAvailableCallBack? onRoomAvailable;
  RemoteCandidateCallBack? onGetRemoteCandidate;

  Future removeRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .delete();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  var database = FirebaseDatabase.instance.ref();

  Future<String> getAgoraToken(String roomName) async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('generateToken');
      final results =
          await callable({'channelName': roomName, 'role': 'publisher'});
      var clientSecret = results.data;
      return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future createRoom(String roomId, Map<String, dynamic> roomData) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .set(roomData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
