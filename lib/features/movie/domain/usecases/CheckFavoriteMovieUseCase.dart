import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class CheckFavoriteMovieUseCase {
  final MovieRepository _movieRepository;

  CheckFavoriteMovieUseCase(this._movieRepository);

  Future<bool> execute(String slug) =>
      _movieRepository.checkFavoriteMovie(slug);
}
