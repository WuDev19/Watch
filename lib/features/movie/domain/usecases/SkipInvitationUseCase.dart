import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/RoomRepository.dart';

@injectable
class SkipInvitationUseCase {
  final RoomRepository _roomRepository;

  SkipInvitationUseCase(this._roomRepository);

  Future<void> execute(String roomId) => _roomRepository.skipInvitation(roomId);
}
