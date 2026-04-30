import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';

class CombineDetailAndWatch {
  String movieSlug;
  String moviePoster;
  int total;
  MovieWatch movieWatch;

  CombineDetailAndWatch({
    required this.movieSlug,
    required this.moviePoster,
    required this.total,
    required this.movieWatch,
  });

  @override
  String toString() {
    return 'CombineDetailAndWatch{movieSlug: $movieSlug, moviePoster: $moviePoster, total: $total, movieWatch: $movieWatch}';
  }
}
