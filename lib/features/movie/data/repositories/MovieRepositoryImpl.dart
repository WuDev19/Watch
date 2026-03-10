import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:movie_app/features/movie/data/datasources/local/CategoryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/remote/api/MovieApi.dart';
import 'package:movie_app/features/movie/data/datasources/remote/helper/NetworkHelper.dart';
import 'package:movie_app/features/movie/data/datasources/remote/mapper/MovieMapper.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
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
          .map(
            (e) => CategoryModel(
              category: e.categoryName,
              categorySlug: e.categorySlug,
            ),
          )
          .toList();
    } else {
      final categoriesDto = await _movieApi.getCategory();
      await _isar.writeTxn(() async {
        final categoriesLocal = categoriesDto.data.items
            .map((e) => CategoryLocal(e.id, e.name, e.slug))
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
    int page,
  ) async {
    final movies = await _movieApi.searchMovieAccordingToCategory(
      category,
      page,
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
  Future<MovieDetails> getMovieDetailsInformation(String slug) async {
    final movieDetails = await _movieApi.movieDetailInfo(slug);
    print("detail $movieDetails");
    return MovieMapper.mapToMovieDetails(movieDetails.data.item);
  }

}
