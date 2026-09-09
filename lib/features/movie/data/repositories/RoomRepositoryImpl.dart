import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';
import 'package:movie_app/features/movie/domain/models/RoomInvited.dart';
import 'package:movie_app/features/movie/domain/models/RoomUpdate.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';
import 'package:movie_app/features/movie/domain/repositories/RoomRepository.dart';

import '../datasources/third-source/base/RoomRemoteDataSource.dart';
import '../datasources/third-source/mapper/RoomMapper.dart';

@LazySingleton(as: RoomRepository)
class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource _roomRemoteDataSource;

  RoomRepositoryImpl(this._roomRemoteDataSource);

  @override
  Future<void> createRoom(RoomCreation roomCreate) async {
    final hostInfo = await _roomRemoteDataSource.getHost();
    if(hostInfo.isEmpty){
      throw Exception("You need to login to use this feature");
    }
    final request = RoomMapper.mapToCreateRoomRequest(
      roomCreate,
      hostInfo["hostId"]!,
      hostInfo["hostName"]!,
    );
    return _roomRemoteDataSource.createRoom(request);
  }

  @override
  Future<bool> checkRoom(String roomId) async {
    return _roomRemoteDataSource.checkRoom(roomId);
  }

  @override
  Stream<RoomWatching?> watching(String roomId) {
    return _roomRemoteDataSource
        .watching(roomId)
        .map(RoomMapper.mapToRoomWatching);
  }

  @override
  Future<void> updateRoom(RoomUpdate roomUpdate) {
    final request = RoomMapper.mapToRoomUpdateRequest(roomUpdate);
    return _roomRemoteDataSource.updateRoom(request);
  }

  @override
  Future<void> deleteRoom(String roomId) {
    return _roomRemoteDataSource.deleteRoom(roomId);
  }

  @override
  Stream<List<RoomInvited>> inviteListen() {
    return _roomRemoteDataSource.inviteListen().map(
      RoomMapper.mapToRoomInvited,
    );
  }
}
