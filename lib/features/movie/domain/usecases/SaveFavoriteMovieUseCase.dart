import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class SaveFavoriteMovieUseCase {
  final MovieRepository _movieRepository;

  SaveFavoriteMovieUseCase(this._movieRepository);

  Future<void> execute(FavoriteMovieModel model) =>
      _movieRepository.saveFavoriteMovie(model);
}
