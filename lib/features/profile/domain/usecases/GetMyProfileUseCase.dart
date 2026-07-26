import 'package:injectable/injectable.dart';

import '../models/Profile.dart';
import '../repositories/UserRepository.dart';

@lazySingleton
class GetMyProfileUseCase {
  final UserRepository _userRepository;

  GetMyProfileUseCase(this._userRepository);

  Future<Profile> execute() => _userRepository.getMyProfile();
}
