import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/RoomRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/MemberResponse.dart';
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
  Stream<List<RoomResponse>> inviteListen() {
    final userId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection(_roomCollection)
        .where('reserveMembers', arrayContains: userId)
        .snapshots()
        .map((event) {
          final invites = <RoomResponse>[];
          for (final doc in event.docs) {
            final room = RoomResponse.fromJson(doc.data());
            if (room == null) continue;
            invites.add(room);
          }
          return invites;
        })
        .handleError((error, stackTrace) {});
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
    final reserveMembers =
        room.data()?["reserveMembers"] as List<MemberResponse>? ?? [];
    if (reserveMembers.isEmpty) return;
    reserveMembers.removeWhere((element) => element.id == memberId);
    return _firebaseFirestore.collection(_roomCollection).doc(roomId).update({
      "reserveMembers": reserveMembers,
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
    final reserveMembers =
        room.data()?["reserveMembers"] as List<MemberResponse>? ??
        []; //lấy danh sách các members được mời nhưng chưa join
    if (reserveMembers.isEmpty) return;
    reserveMembers.removeWhere(
      (element) => element.id == memberId,
    ); //accept/skip thì xóa đi trong reserveMembers
    final members =
        room.data()?["members"] ?? []; //lấy danh sách members hiện tại
    late final DocumentSnapshot<Map<String, dynamic>> userResponse;
    //firestore có cơ chế cache, ưu tiên lấy cache trước cho nhanh
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
    members.add(
      MemberResponse(
        id: memberId,
        name: user.name ?? "",
        avatarUrl: user.avt ?? "",
      ),
    );
    return _firebaseFirestore.collection(_roomCollection).doc(roomId).update({
      "reserveMembers": reserveMembers,
      "members": members,
    });
  }
}
