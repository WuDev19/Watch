import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/UserSearch.dart';
import 'package:movie_app/features/movie/domain/repositories/UserRepository.dart';

import '../datasources/third-source/base/UserRemoteDataSource.dart';
import '../datasources/third-source/mapper/UserMapper.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<List<UserSearch>> searchUser(String keyword) async {
    final response = await _userRemoteDataSource.searchUser(keyword);
    return response.map((e) => UserMapper.mapToUserSearch(e)).toList();
  }
}
