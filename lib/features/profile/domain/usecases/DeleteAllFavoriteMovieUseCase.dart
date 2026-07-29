import 'package:injectable/injectable.dart';

import '../../../movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class DeleteAllFavoriteMovieUseCase {
  final MovieRepository _movieRepository;

  DeleteAllFavoriteMovieUseCase(this._movieRepository);

  Future<void> execute() => _movieRepository.deleteAllFavoriteMovie();
}
