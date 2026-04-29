import 'package:movie_app/features/movie/data/datasources/local/entity/CountryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeListLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/MovieHistory.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/PageEpisodeLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/YearLocal.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/Episode.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';

import '../../../../domain/models/MovieHistoryModel.dart';

abstract class MovieLocalMapper {
  static CountryModel mapToCountryModel(CountryLocal local) {
    return CountryModel(local.countryName, local.countrySlug);
  }

  static YearModel mapToYearModel(YearLocal local) {
    return YearModel(local.year);
  }

  static MovieHistory mapToMovieHistory(MovieHistoryModel model) {
    final episodes = model.movieWatch.episodes
        .map((e) => mapToEpisodeLocal(e))
        .toList();
    final currentListEpisode = model.movieWatch.currentListEpisode
        .map((e) => mapToEpisodeListLocal(e))
        .toList();
    final progress =
        (model.currentEpisode / model.movieDetails.total * 100)
            .roundToDouble() /
        100;
    return MovieHistory(
      name: model.movieWatch.movieName,
      slug: model.movieDetails.slug,
      thumbUrl: model.movieDetails.thumbUrl,
      episodeTotal: model.movieDetails.episodeTotal,
      progress: progress,
      currentEpisode: mapToEpisodeListLocal(model.movieWatch.currentEpisode),
      episodes: episodes,
      currentListEpisode: currentListEpisode,
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
}
