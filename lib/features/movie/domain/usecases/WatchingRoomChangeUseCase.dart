import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/RoomRepository.dart';

import '../models/RoomWatching.dart';

@injectable
class WatchingRoomChangeUseCase {
  final RoomRepository _roomRepository;

  WatchingRoomChangeUseCase(this._roomRepository);

  Stream<RoomWatching?> watching(String roomId) =>
      _roomRepository.watching(roomId);
}
