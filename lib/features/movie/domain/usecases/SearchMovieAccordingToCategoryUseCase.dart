import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class SearchMovieAccordingToCategoryUseCase {
  final MovieRepository _movieRepository;

  SearchMovieAccordingToCategoryUseCase(this._movieRepository);

  Future<List<SearchMovieDisplay>> execute(String category, int page) =>
      _movieRepository.searchMovieAccordingToCategory(category, page);
}
