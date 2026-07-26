import 'package:injectable/injectable.dart';
import 'package:movie_app/features/profile/domain/models/Profile.dart';
import 'package:movie_app/features/profile/domain/repositories/UserRepository.dart';

import '../datasources/third-source/base/UserRemoteDataSource.dart';
import '../datasources/third-source/mapper/UserMapper.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Profile> getMyProfile() async {
    final response = await _userRemoteDataSource.getMyProfile();
    return UserMapper.mapToProfile(response);
  }

  @override
  Future<void> updateAvatar(String file) {
    return _userRemoteDataSource.updateAvatar(file);
  }
}
