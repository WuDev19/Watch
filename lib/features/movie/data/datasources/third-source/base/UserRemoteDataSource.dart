import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/ProfileResponse.dart';

abstract class UserRemoteDataSource {
  Future<ProfileResponse> getMyProfile();
}
