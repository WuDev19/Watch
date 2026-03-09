import 'package:movie_app/features/movie/data/datasources/remote/dto/search/CategoryInSearchPage.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/home/Item.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/search/SearchMovieDTO.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/utils/constants.dart';

class MovieMapper {
  MovieMapper._();

  static MovieDisplay mapToMovieDisplay(Item item) {
    return MovieDisplay(
      movieName: item.name,
      movieStar: item.tmdb.voteAverage,
      moviePoster: Constants.baseImageUrl + item.thumbUrl,
      movieSlug: item.slug,
    );
  }

  static SearchMovieDisplay mapToSearchMovieDisplay(
    SearchMovieDto item,
    int totalItems,
  ) {
    return SearchMovieDisplay(
      movieName: item.name,
      movieYear: item.year,
      moviePoster: Constants.baseImageUrl + item.thumbUrl,
      movieSlug: item.slug,
      totalItems: totalItems,
    );
  }

  static CategoryModel mapToCategoryModel(CategoryInSearchPage item) {
    return CategoryModel(category: item.name, categorySlug: item.slug);
  }
}
