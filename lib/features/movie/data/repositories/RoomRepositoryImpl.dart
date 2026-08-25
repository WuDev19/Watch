import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';
import 'package:movie_app/features/movie/domain/repositories/RoomRepository.dart';

import '../datasources/third-source/base/RoomRemoteDataSource.dart';
import '../datasources/third-source/mapper/RoomMapper.dart';

@LazySingleton(as: RoomRepository)
class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource _roomRemoteDataSource;

  RoomRepositoryImpl(this._roomRemoteDataSource);

  @override
  Future<void> createRoom(RoomCreation roomCreate) {
    final request = RoomMapper.mapToCreateRoomRequest(
      roomCreate,
      _roomRemoteDataSource.getHostId(),
    );
    return _roomRemoteDataSource.createRoom(request);
  }

  @override
  Future<bool> checkRoom(String roomId) async {
    return _roomRemoteDataSource.checkRoom(roomId);
  }

  @override
  Stream<RoomWatching> watching(String roomId) {
    return _roomRemoteDataSource
        .watching(roomId)
        .map(RoomMapper.mapToRoomWatching);
  }
}
