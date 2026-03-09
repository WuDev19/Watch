import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class SearchMovieUseCase {
  final MovieRepository _movieRepository;

  SearchMovieUseCase(this._movieRepository);

  Future<List<SearchMovieDisplay>> execute(String keyword, int page) =>
      _movieRepository.searchMovie(keyword, page);

}
