import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';
import 'package:movie_app/features/movie/domain/models/RoomUpdate.dart';

import '../models/RoomWatching.dart';

abstract class RoomRepository {
  Future<void> createRoom(RoomCreation roomCreate);

  Future<bool> checkRoom(String roomId);

  Stream<RoomWatching> watching(String roomId);

  Future<void> updateRoom(RoomUpdate roomUpdate);
}
