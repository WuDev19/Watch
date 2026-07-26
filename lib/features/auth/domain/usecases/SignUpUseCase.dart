import 'package:injectable/injectable.dart';

import '../models/SignUpModel.dart';
import '../repositories/AuthRepository.dart';

@lazySingleton
class SignUpUseCase {
  final AuthRepository _authRepository;

  const SignUpUseCase(this._authRepository);

  Future<void> signUp(SignUpModel model) => _authRepository.signUp(model);
}
