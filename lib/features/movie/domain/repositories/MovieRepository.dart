import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';

abstract class MovieRepository {
  Future<List<MovieDisplay>> getHomePageMovie();

  Future<List<SearchMovieDisplay>> searchMovie(String keyword, int page);

  Future<List<CategoryModel>> categories();

  Future<List<SearchMovieDisplay>> searchMovieAccordingToCategory(
    String category,
    int page,
  );

  Future<MovieDetails> getMovieDetailsInformation(String slug);

  Future<List<MovieActors>> getMovieActors(String slug);

  Future<List<CountryModel>> getCountry();
}
