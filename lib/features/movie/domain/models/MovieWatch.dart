import 'package:movie_app/features/movie/domain/models/Episode.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';

class MovieWatch {
  String movieName;
  EpisodeList currentEpisode;
  List<Episode> episodes;
  List<EpisodeList> currentListEpisode;

  MovieWatch({
    required this.movieName,
    required this.currentEpisode,
    required this.episodes,
    required this.currentListEpisode,
  });

  @override
  String toString() {
    return 'MovieWatch{movieName: $movieName, currentEpisode: $currentEpisode, episodes: $episodes, currentListEpisode: $currentListEpisode}';
  }
}
