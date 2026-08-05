import 'package:injectable/injectable.dart';

import '../repositories/PersonalRepository.dart';

@lazySingleton
class UpdateAvatarUseCase {
  final PersonalRepository _userRepository;

  UpdateAvatarUseCase(this._userRepository);

  Future<void> execute(String file) => _userRepository.updateAvatar(file);
}
