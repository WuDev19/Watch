import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class HomePageMovieUseCase {
  final MovieRepository _movieRepository;

  HomePageMovieUseCase(this._movieRepository);

  Future<List<MovieDisplay>> execute() => _movieRepository.getHomePageMovie();

}
