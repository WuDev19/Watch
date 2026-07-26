import 'package:injectable/injectable.dart';

import '../repositories/AuthRepository.dart';

@lazySingleton
class LogoutUseCase {
  final AuthRepository _authRepository;

  const LogoutUseCase(this._authRepository);

  Future<bool> execute() => _authRepository.signOut();
}
