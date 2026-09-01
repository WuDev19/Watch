import 'package:injectable/injectable.dart';

import '../repositories/RoomRepository.dart';

@injectable
class DeleteRoomUseCase {
  final RoomRepository _roomRepository;

  DeleteRoomUseCase(this._roomRepository);

  Future<void> execute(String roomId) => _roomRepository.deleteRoom(roomId);
}
