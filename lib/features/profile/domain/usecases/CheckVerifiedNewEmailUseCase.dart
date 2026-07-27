import 'package:injectable/injectable.dart';

import '../repositories/UserRepository.dart';

@lazySingleton
class CheckVerifiedNewEmailUseCase {
  final UserRepository _userRepository;

  CheckVerifiedNewEmailUseCase(this._userRepository);

  Future<void> execute() => _userRepository.checkPendingEmailVerification();
}
