import 'package:injectable/injectable.dart';

import '../repositories/PersonalRepository.dart';

@lazySingleton
class UpdateNameUseCase {
  final PersonalRepository _userRepository;

  UpdateNameUseCase(this._userRepository);

  Future<void> execute(String name) => _userRepository.updateName(name);
}
