import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/mapper/UserMapper.dart';
import 'package:movie_app/features/movie/domain/models/Profile.dart';
import 'package:movie_app/features/movie/domain/repositories/UserRepository.dart';

import '../datasources/third-source/base/UserRemoteDataSource.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Profile> getMyProfile() async {
    final response = await _userRemoteDataSource.getMyProfile();
    return UserMapper.mapToProfile(response);
  }
}
