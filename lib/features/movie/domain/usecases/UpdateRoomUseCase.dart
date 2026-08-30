import 'package:injectable/injectable.dart';

import '../models/RoomUpdate.dart';
import '../repositories/RoomRepository.dart';

@injectable
class UpdateRoomUseCase {
  final RoomRepository _roomRepository;

  UpdateRoomUseCase(this._roomRepository);

  Future<void> execute(RoomUpdate roomUpdate) =>
      _roomRepository.updateRoom(roomUpdate);
}
