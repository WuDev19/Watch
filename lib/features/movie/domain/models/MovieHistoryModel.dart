import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';

class MovieHistoryModel {
  MovieWatch movieWatch;
  MovieDetails movieDetails;
  int currentEpisode;

  MovieHistoryModel({
    required this.movieWatch,
    required this.movieDetails,
    required this.currentEpisode,
  });
}
