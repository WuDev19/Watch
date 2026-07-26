import 'package:movie_app/features/profile/domain/models/Profile.dart';

abstract class UserRepository {
  Future<Profile> getMyProfile();
  Future<void> updateAvatar(String file);
}
