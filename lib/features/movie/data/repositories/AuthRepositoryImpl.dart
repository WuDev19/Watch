import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/SignUpModel.dart';
import 'package:movie_app/features/movie/domain/repositories/AuthRepository.dart';

import '../datasources/third-source/base/AuthRemoteDataSource.dart';
import '../datasources/third-source/mapper/AuthMapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

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
  Future<void> signIn(String email, String password) {
    return _authRemoteDataSource.signInEmailPassword(email, password);
  }

  @override
  Future<void> sendEmailResetPassword(String email) {
    return _authRemoteDataSource.sendEmailResetPassword(email);
  }
}
