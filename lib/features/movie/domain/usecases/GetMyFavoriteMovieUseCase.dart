import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetMyFavoriteMovieUseCase {
  final MovieRepository _movieRepository;

  GetMyFavoriteMovieUseCase(this._movieRepository);

  Future<List<FavoriteMovieModel>> execute(int page, int size) =>
      _movieRepository.getMyFavoriteMovie(page, size);
}
