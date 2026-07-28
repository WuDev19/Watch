import 'package:injectable/injectable.dart';
import 'package:movie_app/features/profile/domain/models/Profile.dart';
import 'package:movie_app/features/profile/domain/repositories/UserRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import '../datasources/third-source/base/UserRemoteDataSource.dart';
import '../datasources/third-source/mapper/UserMapper.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final SharedPreferences _sharedPreferences;

  UserRepositoryImpl(this._userRemoteDataSource, this._sharedPreferences);

  @override
  Future<Profile> getMyProfile() async {
    final response = await _userRemoteDataSource.getMyProfile();
    return UserMapper.mapToProfile(response);
  }

  @override
  Future<void> updateAvatar(String file) {
    return _userRemoteDataSource.updateAvatar(file);
  }

  @override
  Future<void> updateEmail(String email) async {
    await _sharedPreferences.setString(Constants.newEmailKey, email);
    return _userRemoteDataSource.updateEmail(email);
  }

  @override
  Future<void> updateName(String name) {
    return _userRemoteDataSource.updateName(name);
  }

  @override
  Future<bool> checkPendingEmailVerification() async {
    final newEmail = _sharedPreferences.getString(Constants.newEmailKey) ?? "";
    final result = await _userRemoteDataSource.checkPendingEmailVerification(newEmail);
    if(result){
      await _sharedPreferences.remove(Constants.newEmailKey);
      await _sharedPreferences.setString(Constants.emailKey, newEmail);
    }
    return result;
  }
}
