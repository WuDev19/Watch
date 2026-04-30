import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatched.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@injectable
class GetLastWatchedMovieUseCase {
  final MovieRepository _movieRepository;

  GetLastWatchedMovieUseCase(this._movieRepository);

  Future<MovieWatched?> execute() => _movieRepository.getLastWatchedMovie();
}
