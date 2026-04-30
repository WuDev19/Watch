import 'package:movie_app/features/movie/domain/models/Episode.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';

class MovieWatched {
  int id;
  String name;
  String slug;
  String thumbUrl;
  double progress;
  int total;
  EpisodeList currentEpisode;
  List<Episode> episodes;
  List<EpisodeList> currentListEpisode;

  MovieWatched({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbUrl,
    required this.progress,
    required this.total,
    required this.currentEpisode,
    required this.episodes,
    required this.currentListEpisode,
  });

  @override
  String toString() {
    return 'MovieWatched{id: $id, name: $name, slug: $slug, thumbUrl: $thumbUrl, progress: $progress, currentEpisode: $currentEpisode, episodes: $episodes, currentListEpisode: $currentListEpisode}';
  }
}
