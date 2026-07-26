import 'package:injectable/injectable.dart';

import '../repositories/UserRepository.dart';

@lazySingleton
class UpdateAvatarUseCase {
  final UserRepository _userRepository;

  UpdateAvatarUseCase(this._userRepository);

  Future<void> execute(String file) => _userRepository.updateAvatar(file);
}
