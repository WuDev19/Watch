import 'package:movie_app/features/movie/domain/models/Episode.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';

class MovieWatch {
  String movieName;
  EpisodeList currentEpisode;
  List<Episode> episodes;

  MovieWatch({
    required this.movieName,
    required this.currentEpisode,
    required this.episodes,
  });
}
