import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

import '../../../movie/domain/models/MovieWatching.dart';

@lazySingleton
class GetMyHistoryUseCase {
  final MovieRepository _movieRepository;

  GetMyHistoryUseCase(this._movieRepository);

  Future<List<MovieWatching>> execute(int page, int size) =>
      _movieRepository.getMovieHistory(page, size);
}
