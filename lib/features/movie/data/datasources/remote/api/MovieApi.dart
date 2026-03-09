import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/search/CategoryInSearchPage.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/MovieResponse.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/home/Item.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/search/SearchMovieDTO.dart';

@singleton
class MovieApi {
  final Dio _dio;
  CancelToken? _searchToken;

  MovieApi(this._dio);

  Future<MovieResponse<Item>> getHomePageMovie() async {
    final response = await _dio.get("/v1/api/home");
    return MovieResponse.fromJson(
      response.data,
      (jsonT) => Item.fromJson(jsonT),
    );
  }

  Future<MovieResponse<SearchMovieDto>> searchMovie(
    String keyword,
    int page,
  ) async {
    _searchToken?.cancel();
    _searchToken = CancelToken();
    final response = await _dio.get(
      "/v1/api/tim-kiem",
      queryParameters: {"keyword": keyword, "page": page, "limit": 24},
      cancelToken: _searchToken,
    );
    return MovieResponse.fromJson(
      response.data,
      (jsonT) => SearchMovieDto.fromJson(jsonT),
    );
  }

  Future<MovieResponse<CategoryInSearchPage>> getCategory() async {
    final response = await _dio.get("/v1/api/the-loai");
    return MovieResponse.fromJson(
      response.data,
      (jsonT) => CategoryInSearchPage.fromJson(jsonT),
    );
  }

  Future<MovieResponse<SearchMovieDto>> searchMovieAccordingToCategory(
    String category,
    int page,
  ) async {
    final response = await _dio.get(
      "/v1/api/the-loai/$category",
      queryParameters: {
        "page": page,
        "limit": 24,
        "sort_field": "year",
        "sort_type": "desc",
      },
    );
    return MovieResponse.fromJson(
      response.data,
      (jsonT) => SearchMovieDto.fromJson(jsonT),
    );
  }


}
