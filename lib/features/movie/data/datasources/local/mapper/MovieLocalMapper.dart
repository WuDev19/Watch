import 'package:movie_app/features/movie/data/datasources/local/entity/CategoryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/CountryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeListLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/FavoriteMovie.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/MovieHistory.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/PageEpisodeLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/YearLocal.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/CategoryOrCountryDTO.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/Episode.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatched.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';
import 'package:movie_app/utils/constants.dart';

import '../../../../domain/models/MovieHistoryModel.dart';

abstract class MovieLocalMapper {
  static CountryModel mapToCountryModel(CountryLocal local) {
    return CountryModel(local.countryName, local.countrySlug);
  }

  static YearModel mapToYearModel(YearLocal local) {
    return YearModel(local.year);
  }

  static CategoryLocal mapToCategoryLocal(CategoryOrCountryDTO model) {
    return CategoryLocal(model.id, model.name, model.slug);
  }

  static CategoryModel mapToCategoryModel(CategoryLocal local) => CategoryModel(
    id: local.categoryId,
    category: local.categoryName,
    categorySlug: local.categorySlug,
  );

  static MovieHistory mapToMovieHistory(
    MovieHistoryModel model,
    Set<int> watchedEpisode,
  ) {
    final episodes = model.combineDetailAndWatch.movieWatch.episodes
        .map((e) => mapToEpisodeLocal(e))
        .toList();
    final currentListEpisode = model
        .combineDetailAndWatch
        .movieWatch
        .currentListEpisode
        .map((e) => mapToEpisodeListLocal(e))
        .toList();

    return MovieHistory(
      name: model.combineDetailAndWatch.movieWatch.movieName,
      slug: model.combineDetailAndWatch.movieSlug,
      thumbUrl: model.combineDetailAndWatch.moviePoster,
      watchedEpisode: watchedEpisode.toList(),
      total: model.combineDetailAndWatch.total,
      currentEpisode: mapToEpisodeListLocal(
        model.combineDetailAndWatch.movieWatch.currentEpisode,
      ),
      episodes: episodes,
      currentListEpisode: currentListEpisode,
      lastWatched: DateTime.now(),
    );
  }

  static MovieWatching mapToMovieWatching(MovieHistory history) {
    final episodes = <Episode>[];
    for (int i = 0; i < history.episodes.length; i++) {
      episodes.add(mapToEpisode(history.episodes[i], i));
    }
    final currentListEpisode = history.currentListEpisode
        .map((e) => mapToEpisodeList(e))
        .toList();
    final movieWatch = MovieWatch(
      movieName: history.name,
      currentEpisode: mapToEpisodeList(history.currentEpisode),
      episodes: episodes,
      currentListEpisode: currentListEpisode,
    );
    final combineDetailAndWatch = CombineDetailAndWatch(
      movieSlug: history.slug,
      moviePoster: history.thumbUrl,
      total: history.total,
      movieWatch: movieWatch,
    );
    final totalEpisodes = history.total > 0 ? history.total : 1;
    final progress = (history.watchedEpisode.toSet().length / totalEpisodes)
        .toDouble()
        .clamp(0.0, 1.0);

    return MovieWatching(
      combineDetailAndWatch: combineDetailAndWatch,
      progress: progress,
    );
  }

  static MovieWatched mapToMovieWatched(MovieHistory history) {
    final episodes = <Episode>[];
    for (int i = 0; i < history.episodes.length; i++) {
      episodes.add(mapToEpisode(history.episodes[i], i));
    }
    final currentListEpisode = history.currentListEpisode
        .map((e) => mapToEpisodeList(e))
        .toList();
    final totalEpisodes = history.total > 0 ? history.total : 1;
    final progress = (history.watchedEpisode.toSet().length / totalEpisodes)
        .toDouble()
        .clamp(0.0, 1.0);
    return MovieWatched(
      id: history.id,
      name: history.name,
      slug: history.slug,
      thumbUrl: Constants.baseImageUrl + history.thumbUrl,
      progress: progress,
      currentEpisode: mapToEpisodeList(history.currentEpisode),
      episodes: episodes,
      currentListEpisode: currentListEpisode,
      total: history.total,
    );
  }

  static EpisodeLocal mapToEpisodeLocal(Episode episode) {
    final episodeLocal = EpisodeLocal();
    episodeLocal.serverName = episode.serverName;
    episodeLocal.paginationEpisode = mapToPageEpisodeLocal(
      episode.paginationEpisode,
    );
    return episodeLocal;
  }

  static EpisodeListLocal mapToEpisodeListLocal(EpisodeList episodeList) {
    final episodeListLocal = EpisodeListLocal();
    episodeListLocal.name = episodeList.name;
    episodeListLocal.slug = episodeList.slug;
    episodeListLocal.filename = episodeList.filename;
    episodeListLocal.linkM3U8 = episodeList.linkM3U8;
    return episodeListLocal;
  }

  static List<PageEpisodeLocal> mapToPageEpisodeLocal(
    Map<int, List<EpisodeList>> pagination,
  ) {
    final pages = <PageEpisodeLocal>[];
    pagination.forEach((key, value) {
      final local = value.map((e) => mapToEpisodeListLocal(e)).toList();
      final pageEpisode = PageEpisodeLocal();
      pageEpisode.page = key;
      pageEpisode.episodeList = local;
      pages.add(pageEpisode);
    });
    return pages;
  }

  static EpisodeList mapToEpisodeList(EpisodeListLocal local) {
    return EpisodeList(
      name: local.name,
      slug: local.slug,
      filename: local.filename,
      linkM3U8: local.linkM3U8,
    );
  }

  static Episode mapToEpisode(EpisodeLocal local, int position) {
    final pagination = <int, List<EpisodeList>>{};
    for (var element in local.paginationEpisode) {
      final episodeList = element.episodeList
          .map((e) => mapToEpisodeList(e))
          .toList();
      pagination[element.page] = episodeList;
    }
    return position == 0
        ? Episode(
            serverName: local.serverName,
            paginationEpisode: pagination,
            isSelected: true,
          )
        : Episode(
            serverName: local.serverName,
            paginationEpisode: pagination,
            isSelected: false,
          );
  }

  static FavoriteMovie mapToFavoriteMovie(FavoriteMovieModel model) =>
      FavoriteMovie(
        movieName: model.movieName,
        movieSlug: model.movieSlug,
        thumbUrl: model.thumbUrl,
        createdAt: DateTime.now(),
      );

  static FavoriteMovieModel mapToFavoriteMovieModel(FavoriteMovie movie) =>
      FavoriteMovieModel(
        movieName: movie.movieName,
        movieSlug: movie.movieSlug,
        thumbUrl: movie.thumbUrl,
      );
}
