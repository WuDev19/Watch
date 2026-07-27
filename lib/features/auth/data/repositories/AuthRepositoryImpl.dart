import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/models/SignUpModel.dart';
import 'package:movie_app/features/auth/domain/repositories/AuthRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasources/third-source/base/AuthRemoteDataSource.dart';
import '../datasources/third-source/mapper/AuthMapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SharedPreferences _sharedPreferences;

  AuthRepositoryImpl(this._authRemoteDataSource, this._sharedPreferences);

  @override
  Future<bool> checkLogin() {
    return _authRemoteDataSource.checkLogin();
  }

  @override
  Future<bool> signOut() {
    return _authRemoteDataSource.signOut();
  }

  @override
  Future<void> signUp(SignUpModel model) {
    return _authRemoteDataSource.signUpEmailPassword(
      AuthMapper.mapToSignUpRequest(model),
    );
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _sharedPreferences.setString("email", email);
    await _sharedPreferences.setString("password", password);
    _authRemoteDataSource.signInEmailPassword(email, password);
  }

  @override
  Future<void> sendEmailResetPassword(String email) {
    return _authRemoteDataSource.sendEmailResetPassword(email);
  }

  @override
  Future<void> reauthenticate() {
    final email = _sharedPreferences.getString("email") ?? "test@gmail.com";
    final password = _sharedPreferences.getString("password") ?? "123456";
    return _authRemoteDataSource.reauthenticate(email, password);
  }
}
