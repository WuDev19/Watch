import '../dto/response/ProfileResponse.dart';

abstract class PersonalRemoteDataSource {
  Future<ProfileResponse> getMyProfile();

  Future<void> updateAvatar(String file);

  Future<void> updateName(String name);

  Future<void> updateEmail(String email);

  Future<bool> checkPendingEmailVerification(String newEmail);
}
