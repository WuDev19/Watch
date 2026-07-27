import 'package:firebase_auth/firebase_auth.dart';

import '../dto/request/SignUpRequest.dart';

abstract class AuthRemoteDataSource {
  Future<bool> checkLogin();

  Future<UserCredential> signUpEmailPassword(SignUpRequest request);

  Future<UserCredential> signInEmailPassword(String email, String password);

  Future<bool> signOut();

  Future<void> sendEmailResetPassword(String email);

  Future<void> reauthenticate(String email, String password);
}
