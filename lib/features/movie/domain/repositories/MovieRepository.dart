import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';
import '../models/MovieHistoryModel.dart';
import '../models/MovieWatched.dart';

abstract class MovieRepository {
  Future<List<MovieDisplay>> getHomePageMovie();

  Future<List<SearchMovieDisplay>> searchMovie(String keyword, int page);

  Future<List<CategoryModel>> categories();

  Future<List<SearchMovieDisplay>> searchMovieAccordingToCategory(
    String category,
    Map<String, dynamic> params,
  );

  Future<List<SearchMovieDisplay>> searchMovieAccordingToCountry(
    String country,
    Map<String, dynamic> params,
  );

  Future<List<SearchMovieDisplay>> searchMovieAccordingToYear(
    int year,
    Map<String, dynamic> params,
  );

  Future<MovieDetails> getMovieDetailsInformation(String slug);

  Future<List<MovieActors>> getMovieActors(String slug);

  Future<List<CountryModel>> getCountries();

  Future<List<YearModel>> getYears();

  Future<void> saveMovieHistory(MovieHistoryModel model);

  Future<MovieWatched?> getLastWatchedMovie();

  Future<bool> checkFavoriteMovie(String slug);

  Future<void> saveFavoriteMovie(FavoriteMovieModel model);

  Future<void> deleteFavoriteMovie(String slug);

  Future<List<FavoriteMovieModel>> getMyFavoriteMovie();

  Future<List<MovieWatching>> getWatchingMovie();

  Future<List<MovieWatching>> getWatchedMovie();

  Future<void> deleteListFavoriteMovie(List<String> slug);

  Future<void> deleteHistoryMovie(List<String> slug);
}
