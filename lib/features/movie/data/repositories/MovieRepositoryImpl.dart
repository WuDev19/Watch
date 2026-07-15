import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/CategoryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/CountryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/FavoriteMovie.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/MovieHistory.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/YearLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/mapper/MovieLocalMapper.dart';
import 'package:movie_app/features/movie/data/datasources/remote/api/MovieApi.dart';
import 'package:movie_app/features/movie/data/datasources/remote/helper/NetworkHelper.dart';
import 'package:movie_app/features/movie/data/datasources/remote/mapper/MovieMapper.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatched.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieApi _movieApi;
  final Isar _isar;

  MovieRepositoryImpl(this._movieApi, this._isar);

  @override
  Future<List<MovieDisplay>> getHomePageMovie() async {
    final homeDTO = await _movieApi.getHomePageMovie();
    return homeDTO.data.items
        .map((e) => MovieMapper.mapToMovieDisplay(e))
        .toList();
  }

  @override
  Future<List<SearchMovieDisplay>> searchMovie(String keyword, int page) async {
    return NetworkHelper.callApi(_movieApi.searchMovie(keyword, page), (input) {
      return input.data.items
          .map(
            (e) => MovieMapper.mapToSearchMovieDisplay(
              e,
              input.data.params?.pagination?.totalItems ?? 0,
            ),
          )
          .toList();
    });
  }

  @override
  Future<List<CategoryModel>> categories() async {
    final check = await _isar.categoryLocals.count();
    if (check > 0) {
      final categories = await _isar.categoryLocals.where().findAll();
      return categories
          .map((e) => MovieLocalMapper.mapToCategoryModel(e))
          .toList();
    } else {
      final categoriesDto = await _movieApi.getCategory();
      await _isar.writeTxn(() async {
        final categoriesLocal = categoriesDto.data.items
            .map((e) => MovieLocalMapper.mapToCategoryLocal(e))
            .toList();
        _isar.categoryLocals.putAll(categoriesLocal);
      });
      return categoriesDto.data.items
          .map((e) => MovieMapper.mapFromCategorySearchToCategoryModel(e))
          .toList();
    }
  }

  @override
  Future<List<SearchMovieDisplay>> searchMovieAccordingToCategory(
    String category,
    Map<String, dynamic> params,
  ) async {
    final movies = await _movieApi.searchMovieAccordingToCategory(
      category,
      params,
    );
    return movies.data.items
        .map(
          (e) => MovieMapper.mapToSearchMovieDisplay(
            e,
            movies.data.params?.pagination?.totalItems ?? 0,
          ),
        )
        .toList();
  }

  @override
  Future<List<SearchMovieDisplay>> searchMovieAccordingToCountry(
    String country,
    Map<String, dynamic> params,
  ) async {
    final movies = await _movieApi.searchMovieAccordingToCountry(
      country,
      params,
    );
    return movies.data.items
        .map(
          (e) => MovieMapper.mapToSearchMovieDisplay(
            e,
            movies.data.params?.pagination?.totalItems ?? 0,
          ),
        )
        .toList();
  }

  @override
  Future<List<SearchMovieDisplay>> searchMovieAccordingToYear(
    int year,
    Map<String, dynamic> params,
  ) async {
    final movies = await _movieApi.searchMovieAccordingToYear(year, params);
    return movies.data.items
        .map(
          (e) => MovieMapper.mapToSearchMovieDisplay(
            e,
            movies.data.params?.pagination?.totalItems ?? 0,
          ),
        )
        .toList();
  }

  @override
  Future<MovieDetails> getMovieDetailsInformation(String slug) async {
    final movieDetails = await _movieApi.movieDetailInfo(slug);
    return MovieMapper.mapToMovieDetails(movieDetails.data.item);
  }

  @override
  Future<List<MovieActors>> getMovieActors(String slug) async {
    final movieActors = await _movieApi.actorsMovie(slug);
    final profileSize = movieActors.data.profileSizes.w185;
    return movieActors.data.peoples.map((people) {
      return MovieMapper.mapToMovieActors(profileSize, people);
    }).toList();
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    final check = await _isar.countryLocals.count();
    if (check > 0) {
      final data = await _isar.countryLocals.where().findAll();
      return data.map((e) => MovieLocalMapper.mapToCountryModel(e)).toList();
    } else {
      final response = await _movieApi.getCountries();
      await _isar.writeTxn(() async {
        final listCountry = response.data.items
            .map((e) => MovieMapper.mapToCountryLocal(e))
            .toList();
        _isar.countryLocals.putAll(listCountry);
      });
      return response.data.items
          .map((e) => MovieMapper.mapToCountryModel(e))
          .toList();
    }
  }

  @override
  Future<List<YearModel>> getYears() async {
    final check = await _isar.yearLocals.count();
    if (check > 0) {
      final data = await _isar.yearLocals.where().findAll();
      return data.map((e) => MovieLocalMapper.mapToYearModel(e)).toList();
    } else {
      final response = await _movieApi.getYears();
      await _isar.writeTxn(() async {
        final listYear = response.data.items
            .map((e) => MovieMapper.mapToYearLocal(e))
            .toList();
        _isar.yearLocals.putAll(listYear);
      });
      return response.data.items
          .map((e) => MovieMapper.mapToYearModel(e))
          .toList();
    }
  }

  @override
  Future<void> saveMovieHistory(MovieHistoryModel model) async {
    //phải await ko là chưa kịp mở transaction thì hàm đã chạy xong
    await _isar.writeTxn(() async {
      final tmpMovieHistory = await _isar.movieHistorys
          .where()
          .slugEqualTo(model.combineDetailAndWatch.movieSlug)
          .findFirst();
      final watchedEpisode = tmpMovieHistory?.watchedEpisode.toSet() ?? {};
      watchedEpisode.add(model.currentEpisode);
      final movieHistory = MovieLocalMapper.mapToMovieHistory(
        model,
        watchedEpisode,
      );
      await _isar.movieHistorys.put(
        movieHistory,
      ); //phải await ko là chưa kịp put thì transaction đã đóng
    });
  }

  @override
  Future<MovieWatched?> getLastWatchedMovie() async {
    final movieHistory = await _isar.movieHistorys
        .where()
        .sortByLastWatchedDesc()
        .limit(1)
        .findFirst();
    if (movieHistory == null) return null;
    return MovieLocalMapper.mapToMovieWatched(movieHistory);
  }

  @override
  Future<bool> checkFavoriteMovie(String slug) async {
    final result = await _isar.favoriteMovies
        .where()
        .movieSlugEqualTo(slug)
        .count();
    return result > 0;
  }

  @override
  Future<void> saveFavoriteMovie(FavoriteMovieModel model) async {
    final favoriteMovie = MovieLocalMapper.mapToFavoriteMovie(model);
    await _isar.writeTxn(() async {
      await _isar.favoriteMovies.put(favoriteMovie);
    });
  }

  @override
  Future<void> deleteFavoriteMovie(String slug) async {
    final favoriteMovie = await _isar.favoriteMovies
        .where()
        .movieSlugEqualTo(slug)
        .findFirst();
    if (favoriteMovie != null) {
      await _isar.writeTxn(() async {
        await _isar.favoriteMovies.deleteByMovieSlug(slug);
      });
    }
  }

  @override
  Future<List<FavoriteMovieModel>> getMyFavoriteMovie() async {
    final result = await _isar.favoriteMovies.where().anyCreatedAt().findAll();
    return result
        .map((e) => MovieLocalMapper.mapToFavoriteMovieModel(e))
        .toList();
  }

  @override
  Future<List<MovieWatching>> getWatchingMovie() async {
    final result = await _isar.movieHistorys
        .where()
        .sortByLastWatchedDesc()
        .findAll();
    return result
        .map((e) => MovieLocalMapper.mapToMovieWatching(e))
        .where((element) => element.progress < 1)
        .toList();
  }

  @override
  Future<List<MovieWatching>> getWatchedMovie() async {
    final result = await _isar.movieHistorys
        .where()
        .sortByLastWatchedDesc()
        .findAll();
    return result
        .map((e) => MovieLocalMapper.mapToMovieWatching(e))
        .where((element) => element.progress >= 1)
        .toList();
  }

  @override
  Future<void> deleteListFavoriteMovie(List<String> slug) async {
    await _isar.writeTxn(() async {
      await _isar.favoriteMovies.deleteAllByMovieSlug(slug);
    });
  }

  @override
  Future<void> deleteHistoryMovie(List<String> slug) async {
    await _isar.writeTxn(() async {
      await _isar.movieHistorys.deleteAllBySlug(slug);
    });
  }
}
