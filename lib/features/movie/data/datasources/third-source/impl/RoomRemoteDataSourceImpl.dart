import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/RoomRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomResponse.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomUpdateRequest.dart';

@LazySingleton(as: RoomRemoteDataSource)
class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  static final String _roomCollection = "rooms";
  static final String _userCollection = "users";

  RoomRemoteDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<void> createRoom(CreateRoomRequest request) {
    return _firebaseFirestore
        .collection(_roomCollection)
        .doc(request.roomId)
        .set(request.toJson());
  }

  @override
  Future<Map<String, String>> getHost() async {
    final hostId = _firebaseAuth.currentUser?.uid;
    if(hostId == null) return {};
    final result = await _firebaseFirestore.collection(_userCollection).doc(
        hostId).get();
    final hostName = result.data()!['name'];
    return {
      "hostId": hostId,
      "hostName": hostName
    };
  }

  @override
  Future<bool> checkRoom(String roomId) async {
    final response = await _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .get();
    return response
        .data()
        ?.isNotEmpty ?? false;
  }

  @override
  Stream<RoomResponse?> watching(String roomId) {
    return _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .snapshots()
        .map((event) => RoomResponse.fromJson(event.data()));
  }

  @override
  Future<void> updateRoom(RoomUpdateRequest request) {
    final roomId = request.roomId;
    final updateData = <String, dynamic>{};
    if (request.playing != null) {
      updateData['isPlaying'] = request.playing;
    }
    if (request.playbackRate != null) {
      updateData['playbackRate'] = request.playbackRate;
    }
    if (request.movieUrl != null) {
      updateData['movieUrl'] = request.movieUrl;
    }
    if (request.currentTime != null) {
      updateData['currentTime'] = request.currentTime;
    }
    return _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .update(updateData);
  }

  @override
  Future<void> deleteRoom(String roomId) {
    return _firebaseFirestore.collection(_roomCollection).doc(roomId).delete();
  }

  @override
  Stream<List<RoomResponse>> inviteListen() {
    final userId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection(_roomCollection)
        .where('reserveMembers', arrayContains: userId)
        .snapshots()
        .map((event) {
      final invites = <RoomResponse>[];
      for (final change in event.docChanges) {
        if (change.type != DocumentChangeType.added) continue;
        final room = RoomResponse.fromJson(change.doc.data());
        if (room == null) continue;
        invites.add(room);
      }
      return invites;
    });
  }
}
