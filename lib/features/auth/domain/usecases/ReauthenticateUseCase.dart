import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/repositories/AuthRepository.dart';

@lazySingleton
class ReauthenticateUseCase {
  final AuthRepository _authRepository;

  ReauthenticateUseCase(this._authRepository);

  Future<void> execute() => _authRepository.reauthenticate();
}
