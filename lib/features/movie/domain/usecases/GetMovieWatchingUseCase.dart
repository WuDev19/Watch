import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetMovieWatchingUseCase {
  final MovieRepository _movieRepository;

  GetMovieWatchingUseCase(this._movieRepository);

  Future<List<MovieWatching>> execute() => _movieRepository.getWatchingMovie();
}
