import 'package:injectable/injectable.dart';

import '../repositories/AuthRepository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<void> execute(String email, String password) =>
      _authRepository.signIn(email, password);
}
