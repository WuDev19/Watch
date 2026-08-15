import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/RoomRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/CreateRoomRequest.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/RoomResponse.dart';

@LazySingleton(as: RoomRemoteDataSource)
class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  static final String _roomCollection = "rooms";

  RoomRemoteDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<void> createRoom(CreateRoomRequest request) {
    return _firebaseFirestore.collection(_roomCollection).add(request.toJson());
  }

  @override
  String getHostId() {
    return _firebaseAuth.currentUser!.uid;
  }

  @override
  Future<RoomResponse> getRoomDetail(String roomId) async {
    final response = await _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .get();
    return RoomResponse.fromJson(response.data()!);
  }

  @override
  Stream<RoomResponse> watching(String roomId) {
    return _firebaseFirestore
        .collection(_roomCollection)
        .doc(roomId)
        .snapshots()
        .map((event) => RoomResponse.fromJson(event.data()!));
  }
}
