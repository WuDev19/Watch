import 'package:isar_community/isar.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeListLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/PageEpisodeLocal.dart';

part 'MovieHistory.g.dart';

@collection
class MovieHistory {
  Id id = Isar.autoIncrement;
  String name;
  @Index(unique: true, replace: true)
  String slug;
  String thumbUrl;
  String episodeTotal;
  double progress;
  EpisodeListLocal currentEpisode;
  List<EpisodeLocal> episodes;
  List<EpisodeListLocal> currentListEpisode;

  MovieHistory({
    required this.name,
    required this.slug,
    required this.thumbUrl,
    required this.episodeTotal,
    required this.progress,
    required this.currentEpisode,
    required this.episodes,
    required this.currentListEpisode,
  });

  @override
  String toString() {
    return 'MovieHistory{id: $id, name: $name, thumbUrl: $thumbUrl, episodeTotal: $episodeTotal, progress: $progress, currentEpisode: $currentEpisode, episodes: $episodes, currentListEpisode: $currentListEpisode}';
  }
}
