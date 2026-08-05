import 'package:injectable/injectable.dart';

import '../repositories/PersonalRepository.dart';

@lazySingleton
class UpdateEmailUseCase {
  final PersonalRepository _userRepository;

  UpdateEmailUseCase(this._userRepository);

  Future<void> execute(String email) => _userRepository.updateEmail(email);
}
