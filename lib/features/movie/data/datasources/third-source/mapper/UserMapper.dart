import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/UserResponse.dart';
import 'package:movie_app/features/movie/domain/models/UserSearch.dart';

class UserMapper {
  UserMapper._();

  static UserSearch mapToUserSearch(UserResponse response) => UserSearch(
    userId: response.userId ?? "",
    avt: response.avt ?? "",
    name: response.name ?? "Unknown",
  );
}
