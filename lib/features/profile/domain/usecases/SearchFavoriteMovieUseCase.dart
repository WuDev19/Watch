import 'package:injectable/injectable.dart';

import '../../../movie/domain/models/FavoriteMovieModel.dart';
import '../../../movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class SearchFavoriteMovieUseCase {
  final MovieRepository _movieRepository;

  SearchFavoriteMovieUseCase(this._movieRepository);

  Future<List<FavoriteMovieModel>> execute(
    String keyword,
    int page,
    int size,
  ) => _movieRepository.searchFavoriteMovie(keyword, page, size);
}
