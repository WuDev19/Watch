import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../base/PersonalRemoteDataSource.dart';
import '../dto/response/ProfileResponse.dart';

@LazySingleton(as: PersonalRemoteDataSource)
class PersonalRemoteDataSourceImpl implements PersonalRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final CloudinaryPublic cloudinary;
  static const String _users = "users";

  PersonalRemoteDataSourceImpl(
    this._firebaseFirestore,
    this._firebaseAuth,
    this.cloudinary,
  );

  @override
  Future<ProfileResponse> getMyProfile() async {
    final result = await _firebaseFirestore
        .collection(_users)
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return ProfileResponse.fromJson(result.data() ?? {});
  }

  @override
  Future<void> updateAvatar(String file) async {
    final cloudinaryResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(file, resourceType: CloudinaryResourceType.Image),
    );
    _firebaseFirestore
        .collection(_users)
        .doc(_firebaseAuth.currentUser!.uid)
        .update({"avt": cloudinaryResponse.secureUrl});
  }

  @override
  Future<void> updateEmail(String email) =>
      _firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);

  @override
  Future<void> updateName(String name) => _firebaseFirestore
      .collection(_users)
      .doc(_firebaseAuth.currentUser!.uid)
      .update({"name": name});

  @override
  Future<bool> checkPendingEmailVerification(String newEmail) async {
    if (newEmail.isEmpty) return false;
    final user = _firebaseAuth.currentUser;
    if (user == null) return false;
    try {
      await user.reload();
      final refreshedUser = _firebaseAuth.currentUser;
      if (refreshedUser?.email == newEmail) {
        await _firebaseFirestore
            .collection(_users)
            .doc(refreshedUser!.uid)
            .update({"email": newEmail});
        return true;
      }
    } catch (e) {
      print("Lỗi khi check email mới ${e.toString()}");
      return false;
    }
    return false;
  }
}
