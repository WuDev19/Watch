import '../dto/response/ProfileResponse.dart';

abstract class UserRemoteDataSource {
  Future<ProfileResponse> getMyProfile();
}
