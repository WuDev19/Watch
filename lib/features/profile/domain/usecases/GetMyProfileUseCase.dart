import 'package:injectable/injectable.dart';

import '../models/Profile.dart';
import '../repositories/PersonalRepository.dart';

@lazySingleton
class GetMyProfileUseCase {
  final PersonalRepository _userRepository;

  GetMyProfileUseCase(this._userRepository);

  Future<Profile> execute() => _userRepository.getMyProfile();
}
