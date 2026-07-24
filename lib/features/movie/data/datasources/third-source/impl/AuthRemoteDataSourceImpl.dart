import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/AuthRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/SignUpRequest.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<bool> checkLogin() async {
    return _firebaseAuth.currentUser != null ? true : false;
  }

  @override
  Future<bool> signOut() async {
    await _firebaseAuth.signOut();
    return true;
  }

  @override
  Future<UserCredential> signUpEmailPassword(SignUpRequest request) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    await _firebaseFirestore
        .collection("users")
        .doc(userCredential.user!.uid)
        .set({
          "email": request.email,
          "name": request.name,
          "isActive": request.isActive,
        });
    return userCredential;
  }

  @override
  Future<UserCredential> signInEmailPassword(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> sendEmailResetPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
