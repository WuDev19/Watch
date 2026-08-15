import 'package:injectable/injectable.dart';

import '../models/RoomWatching.dart';
import '../repositories/RoomRepository.dart';

@injectable
class GetRoomWatchingUseCase {
  final RoomRepository _roomRepository;

  GetRoomWatchingUseCase(this._roomRepository);

  Future<RoomWatching> execute(String roomId) =>
      _roomRepository.getRoomDetail(roomId);
}
