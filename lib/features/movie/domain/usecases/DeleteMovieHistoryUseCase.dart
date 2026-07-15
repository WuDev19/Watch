import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class DeleteMovieHistoryUseCase {
  final MovieRepository _movieRepository;

  DeleteMovieHistoryUseCase(this._movieRepository);

  Future<void> execute(List<String> slugs) =>
      _movieRepository.deleteHistoryMovie(slugs);
}
