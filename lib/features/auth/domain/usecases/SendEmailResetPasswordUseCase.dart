import 'package:injectable/injectable.dart';

import '../repositories/AuthRepository.dart';

@lazySingleton
class SendEmailResetPasswordUseCase {
  final AuthRepository _authRepository;

  const SendEmailResetPasswordUseCase(this._authRepository);

  Future<void> execute(String email) =>
      _authRepository.sendEmailResetPassword(email);
}
