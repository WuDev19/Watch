import 'package:injectable/injectable.dart';

import '../../../movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class DeleteAllMovieHistoryUseCase {
  final MovieRepository _movieRepository;

  DeleteAllMovieHistoryUseCase(this._movieRepository);

  Future<void> execute() => _movieRepository.deleteAllMovieHistory();
}
