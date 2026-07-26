import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../base/UserRemoteDataSource.dart';
import '../dto/response/ProfileResponse.dart';

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final CloudinaryPublic cloudinary;

  UserRemoteDataSourceImpl(
    this._firebaseFirestore,
    this._firebaseAuth,
    this.cloudinary,
  );

  @override
  Future<ProfileResponse> getMyProfile() async {
    final result = await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return ProfileResponse.fromJson(result.data() ?? {});
  }

  @override
  Future<void> updateAvatar(String file) async {
    final cloudinaryResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        file,
        resourceType: CloudinaryResourceType.Image,
      ),
    );
    _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .update({"avt": cloudinaryResponse.secureUrl});
  }
}
