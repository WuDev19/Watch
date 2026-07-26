import 'package:injectable/injectable.dart';

import '../repositories/UserRepository.dart';

@lazySingleton
class UpdateNameUseCase {
  final UserRepository _userRepository;

  UpdateNameUseCase(this._userRepository);

  Future<void> execute(String name) => _userRepository.updateName(name);
}
