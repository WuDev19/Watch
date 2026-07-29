import 'package:injectable/injectable.dart';

import '../../../movie/domain/models/MovieWatching.dart';
import '../../../movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class SearchMovieHistoryUseCase {
  final MovieRepository _movieRepository;

  SearchMovieHistoryUseCase(this._movieRepository);

  Future<List<MovieWatching>> execute(String keyword, int page, int size) =>
      _movieRepository.searchMovieHistory(keyword, page, size);
}
