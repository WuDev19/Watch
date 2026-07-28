import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetWatchedMovieUseCase {
  final MovieRepository _movieRepository;

  GetWatchedMovieUseCase(this._movieRepository);

  Future<List<MovieWatching>> execute(int page, int size) =>
      _movieRepository.getWatchedMovie(page, size);
}
