import 'package:injectable/injectable.dart';

import '../repositories/AuthRepository.dart';

@lazySingleton
class CheckLoginUseCase {
  final AuthRepository _authRepository;

  const CheckLoginUseCase(this._authRepository);

  Future<bool> execute() => _authRepository.checkLogin();
}
