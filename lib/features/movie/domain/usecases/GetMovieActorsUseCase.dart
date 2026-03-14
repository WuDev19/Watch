import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetMovieActorsUseCase {
  final MovieRepository _movieRepository;

  GetMovieActorsUseCase(this._movieRepository);

  Future<List<MovieActors>> execute(String slug) =>
      _movieRepository.getMovieActors(slug);
}
