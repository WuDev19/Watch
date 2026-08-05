import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/UserResponse.dart';

abstract class UserRemoteDataSource {
  Future<List<UserResponse>> searchUser(String keyword);
}