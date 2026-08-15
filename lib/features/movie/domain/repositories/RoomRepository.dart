import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';

import '../models/RoomWatching.dart';

abstract class RoomRepository {
  Future<void> createRoom(RoomCreation roomCreate);

  Future<RoomWatching> getRoomDetail(String roomId);

  Stream<RoomWatching> watching(String roomId);
}
