import 'package:injectable/injectable.dart';

import '../repositories/PersonalRepository.dart';

@lazySingleton
class CheckVerifiedNewEmailUseCase {
  final PersonalRepository _userRepository;

  CheckVerifiedNewEmailUseCase(this._userRepository);

  Future<bool> execute() => _userRepository.checkPendingEmailVerification();
}
