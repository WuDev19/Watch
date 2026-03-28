import 'package:injectable/injectable.dart';

import '../models/SearchMovieDisplay.dart';
import '../repositories/MovieRepository.dart';

@lazySingleton
class SearchMovieAccordingToYearUseCase {
  final MovieRepository _movieRepository;

  SearchMovieAccordingToYearUseCase(this._movieRepository);

  Future<List<SearchMovieDisplay>> execute(
    int year,
    Map<String, dynamic> params,
  ) => _movieRepository.searchMovieAccordingToYear(year, params);
}
