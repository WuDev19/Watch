import 'package:injectable/injectable.dart';

import '../models/SearchMovieDisplay.dart';
import '../repositories/MovieRepository.dart';

@lazySingleton
class SearchMovieAccordingToCountryUseCase {
  final MovieRepository _movieRepository;

  SearchMovieAccordingToCountryUseCase(this._movieRepository);

  Future<List<SearchMovieDisplay>> execute(
    String country,
    Map<String, dynamic> params,
  ) => _movieRepository.searchMovieAccordingToCountry(country, params);
}
