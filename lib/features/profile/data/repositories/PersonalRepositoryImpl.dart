import 'package:injectable/injectable.dart';
import 'package:movie_app/features/profile/domain/models/Profile.dart';
import 'package:movie_app/features/profile/domain/repositories/PersonalRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import '../datasources/third-source/base/PersonalRemoteDataSource.dart';
import '../datasources/third-source/mapper/PersonalMapper.dart';

@LazySingleton(as: PersonalRepository)
class PersonalRepositoryImpl implements PersonalRepository {
  final PersonalRemoteDataSource _userRemoteDataSource;
  final SharedPreferences _sharedPreferences;

  PersonalRepositoryImpl(this._userRemoteDataSource, this._sharedPreferences);

  @override
  Future<Profile> getMyProfile() async {
    final response = await _userRemoteDataSource.getMyProfile();
    return PersonalMapper.mapToProfile(response);
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
