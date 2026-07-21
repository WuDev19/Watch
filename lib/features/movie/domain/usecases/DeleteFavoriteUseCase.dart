import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class DeleteFavoriteUseCase {
  final MovieRepository _movieRepository;

  DeleteFavoriteUseCase(this._movieRepository);

  Future<void> execute(String slug) =>
      _movieRepository.deleteFavoriteMovie(slug);
}
