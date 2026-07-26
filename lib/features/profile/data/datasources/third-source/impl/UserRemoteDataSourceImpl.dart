import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../base/UserRemoteDataSource.dart';
import '../dto/response/ProfileResponse.dart';

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  UserRemoteDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<ProfileResponse> getMyProfile() async {
    final result = await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return ProfileResponse.fromJson(result.data() ?? {});
  }
}
