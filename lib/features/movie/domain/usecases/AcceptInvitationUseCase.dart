import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/RoomRepository.dart';

@injectable
class AcceptInvitationUseCase {
  final RoomRepository _roomRepository;

  AcceptInvitationUseCase(this._roomRepository);

  Future<void> execute(String roomId) =>
      _roomRepository.acceptInvitation(roomId);
}
