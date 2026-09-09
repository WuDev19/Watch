import 'package:injectable/injectable.dart';

import '../models/RoomInvited.dart';
import '../repositories/RoomRepository.dart';

@injectable
class WatchingRoomInvitedUseCase {
  final RoomRepository _roomRepository;

  WatchingRoomInvitedUseCase(this._roomRepository);

  Stream<List<RoomInvited>> watchingRoomInvited() =>
      _roomRepository.inviteListen();
}
