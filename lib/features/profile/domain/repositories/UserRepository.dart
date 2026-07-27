import 'package:movie_app/features/profile/domain/models/Profile.dart';

abstract class UserRepository {
  Future<Profile> getMyProfile();

  Future<void> updateAvatar(String file);

  Future<void> updateName(String name);

  Future<void> updateEmail(String email);

  Future<void> checkPendingEmailVerification();
}
