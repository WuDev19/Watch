import 'package:injectable/injectable.dart';

import '../repositories/MovieRepository.dart';

@lazySingleton
class DeleteListFavoriteMovieUseCase {
  final MovieRepository _movieRepository;

  DeleteListFavoriteMovieUseCase(this._movieRepository);

  Future<void> execute(List<String> slug) =>
      _movieRepository.deleteListFavoriteMovie(slug);
}
