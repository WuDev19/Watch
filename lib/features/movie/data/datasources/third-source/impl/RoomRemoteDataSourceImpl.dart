import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/RoomRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomResponse.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomUpdateRequest.dart';
import 'package:movie_app/features/profile/domain/models/Profile.dart';

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
    if (hostId == null) return {};
    final result = await _firebaseFirestore
        .collection(_userCollection)
        .doc(hostId)
        .get();
    final hostName = result.data()!['name'];
    return {"hostId": hostId, "hostName": hostName};
  }

  @override
  Future<bool> checkRoom(String roomId) async {
    final response = await _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .get();
    return response.data()?.isNotEmpty ?? false;
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
  Stream<List<RoomResponse>> inviteListen() async* {
    await for (final user in _firebaseAuth.authStateChanges()) {
      if (user != null) {
        yield* _firebaseFirestore
            .collection(_roomCollection)
            .where('reserveMemberIds', arrayContains: user.uid)
            .snapshots()
            .map((event) {
          final invites = <RoomResponse>[];
          for (final doc in event.docs) {
            final room = RoomResponse.fromJson(doc.data());
            if (room == null) continue;
            invites.add(room);
          }
          return invites;
        });
      } else {
        yield <RoomResponse>[];
      }
    }
  }

  @override
  Future<void> skipInvitation(String roomId) async {
    final memberId = _firebaseAuth.currentUser?.uid;
    if (memberId == null) {
      throw Exception("You need to login to use this feature");
    }
    final room = await _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .get();
    final reserveMembersRaw =
        (room.data()?["reserveMembers"] as List<dynamic>?) ?? [];
    final updatedReserveMembers = reserveMembersRaw
        .where((element) => element is Map && element["id"] != memberId)
        .toList();
    return _firebaseFirestore.collection(_roomCollection).doc(roomId).update({
      "reserveMemberIds": FieldValue.arrayRemove([memberId]),
      "reserveMembers": updatedReserveMembers,
    });
  }

  @override
  Future<void> acceptInvitation(String roomId) async {
    final memberId = _firebaseAuth.currentUser?.uid;
    if (memberId == null) {
      throw Exception("You need to login to use this feature");
    }
    final room = await _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .get();
    final reserveMembersRaw =
        (room.data()?["reserveMembers"] as List<dynamic>?) ?? [];
    final updatedReserveMembers = reserveMembersRaw
        .where((element) => element is Map && element["id"] != memberId)
        .toList();
    final membersRaw = (room.data()?["members"] as List<dynamic>?) ?? [];
    final members = membersRaw.toList();
    late final DocumentSnapshot<Map<String, dynamic>> userResponse;
    try {
      userResponse = await _firebaseFirestore
          .collection(_userCollection)
          .doc(memberId)
          .get(GetOptions(source: Source.cache));
    } on FirebaseException {
      userResponse = await _firebaseFirestore
          .collection(_userCollection)
          .doc(memberId)
          .get();
    }
    final user = Profile.fromJson(userResponse.data()!);
    members.add({
      "id": memberId,
      "name": user.name ?? "",
      "avatarUrl": user.avt ?? "",
    });
    return _firebaseFirestore.collection(_roomCollection).doc(roomId).update({
      "reserveMemberIds": FieldValue.arrayRemove([memberId]),
      "reserveMembers": updatedReserveMembers,
      "members": members,
    });
  }
}
