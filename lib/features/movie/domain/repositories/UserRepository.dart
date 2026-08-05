import 'package:movie_app/features/movie/domain/models/UserSearch.dart';

abstract class UserRepository {
  Future<List<UserSearch>> searchUser(String keyword);
}