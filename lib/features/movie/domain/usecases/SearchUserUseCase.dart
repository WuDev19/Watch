import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/UserSearch.dart';

import '../repositories/UserRepository.dart';

@lazySingleton
class SearchUserUseCase {
  final UserRepository _userRepository;

  SearchUserUseCase(this._userRepository);

  Future<List<UserSearch>> execute(String keyword) =>
      _userRepository.searchUser(keyword);
}
