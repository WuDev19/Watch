import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/base/UserRemoteDataSource.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/UserResponse.dart';

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  UserRemoteDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<UserResponse>> searchUser(String keyword) async {
    final result = await _firebaseFirestore
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: keyword)
        .where("name", isLessThan: "$keyword\uf8ff")
        .get();
    return result.docs.map((e) => UserResponse.fromJson(e.data())).toList();
  }
}
