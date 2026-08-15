import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/RoomRepository.dart';

import '../models/RoomCreation.dart';

@injectable
class CreateRoomUseCase {
  final RoomRepository _roomRepository;

  CreateRoomUseCase(this._roomRepository);

  Future<void> execute(RoomCreation roomCreate) =>
      _roomRepository.createRoom(roomCreate);
}
