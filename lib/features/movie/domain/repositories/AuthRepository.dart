import 'package:movie_app/features/movie/domain/models/SignUpModel.dart';

abstract class AuthRepository {
  Future<void> signUp(SignUpModel model);

  Future<void> signIn(String email, String password);

  Future<bool> signOut();

  Future<bool> checkLogin();

  Future<void> sendEmailResetPassword(String email);
}
