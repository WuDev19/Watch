import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetMovieDetailsInfoUseCase {
  final MovieRepository _movieRepository;

  GetMovieDetailsInfoUseCase(this._movieRepository);

  Future<MovieDetails> execute(String slug) =>
      _movieRepository.getMovieDetailsInformation(slug);

}
