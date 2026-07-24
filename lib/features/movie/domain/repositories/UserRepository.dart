import 'package:movie_app/features/movie/domain/models/Profile.dart';

abstract class UserRepository {
  Future<Profile> getMyProfile();
}
