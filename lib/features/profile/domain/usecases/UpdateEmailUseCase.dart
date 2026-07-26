import 'package:injectable/injectable.dart';

import '../repositories/UserRepository.dart';

@lazySingleton
class UpdateEmailUseCase {
  final UserRepository _userRepository;

  UpdateEmailUseCase(this._userRepository);

  Future<void> execute(String email) => _userRepository.updateEmail(email);
}
