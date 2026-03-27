import 'package:movie_app/features/movie/data/datasources/local/entity/CountryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/CategoryDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/EpisodeDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/EpisodeListDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/MovieDetailsDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/PeopleDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/CategoryOrCountryDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/home/Item.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/search/SearchMovieDTO.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/Episode.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:intl/intl.dart';

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

  static CategoryModel mapFromCategorySearchToCategoryModel(
    CategoryOrCountryDTO item,
  ) {
    return CategoryModel(category: item.name, categorySlug: item.slug);
  }

  static CategoryModel mapFromCategoryDtoToCategoryModel(CategoryDTO item) {
    return CategoryModel(category: item.name, categorySlug: item.slug);
  }

  static Episode mapToEpisodeModel(EpisodeDTO episode) {
    final episodeList = episode.episodeList
        .map((e) => mapToEpisodeListModel(e))
        .toList();
    return Episode(serverName: episode.serverName, episodeList: episodeList);
  }

  static EpisodeList mapToEpisodeListModel(EpisodeListDTO episodeList) {
    return EpisodeList(
      filename: episodeList.filename,
      linkM3U8: episodeList.linkM3U8,
    );
  }

  static MovieDetails mapToMovieDetails(MovieDetailsDTO movieDetails) {
    final category = movieDetails.category
        .map((e) => mapFromCategoryDtoToCategoryModel(e))
        .toList();
    final country = movieDetails.country.map((e) => e.name).join(", ");
    final episodes = movieDetails.episodes
        .map((e) => mapToEpisodeModel(e))
        .toList();
    final created = DateTime.parse(movieDetails.created.time);
    final releaseDate = DateFormat("dd/MM/yyyy").format(created);
    final content = _parseHtmlString(movieDetails.content);
    return MovieDetails(
      movieStar: movieDetails.tmdb.voteAverage,
      releaseDate: releaseDate,
      name: movieDetails.name,
      slug: movieDetails.slug,
      originName: movieDetails.originName,
      content: content,
      type: movieDetails.type,
      status: movieDetails.status,
      thumbUrl: movieDetails.thumbUrl,
      posterUrl: movieDetails.posterUrl,
      trailerUrl: movieDetails.trailerUrl,
      time: movieDetails.time,
      episodeCurrent: movieDetails.episodeCurrent,
      episodeTotal: movieDetails.episodeTotal,
      quality: movieDetails.quality,
      lang: movieDetails.lang,
      year: movieDetails.year,
      view: movieDetails.view,
      category: category,
      country: country,
      episodes: episodes,
      alternativeNames: movieDetails.alternativeNames,
    );
  }

  static MovieActors mapToMovieActors(String profileSize, PeopleDTO people) {
    return MovieActors(
      name: people.name,
      originalName: people.originalName,
      profilePicture: profileSize + people.profilePath,
    );
  }

  static CountryModel mapToCountryModel(CategoryOrCountryDTO item) {
    return CountryModel(item.name, item.slug);
  }

  static CountryLocal mapToCountryLocal(CategoryOrCountryDTO item) {
    return CountryLocal(item.id, item.name, item.slug);
  }

  static String _parseHtmlString(String htmlString) {
    String step1 = htmlString.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
    return step1.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
