import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

import '../models/MovieHistoryModel.dart';

@lazySingleton
class SaveMovieHistoryUseCase {
  final MovieRepository _movieRepository;

  SaveMovieHistoryUseCase(this._movieRepository);

  Future<void> execute(MovieHistoryModel model) =>
      _movieRepository.saveMovieHistory(model);
}
