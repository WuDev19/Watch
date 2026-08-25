import 'package:injectable/injectable.dart';

import '../repositories/RoomRepository.dart';

@injectable
class GetRoomWatchingUseCase {
  final RoomRepository _roomRepository;

  GetRoomWatchingUseCase(this._roomRepository);

  Future<bool> execute(String roomId) =>
      _roomRepository.checkRoom(roomId);
}
