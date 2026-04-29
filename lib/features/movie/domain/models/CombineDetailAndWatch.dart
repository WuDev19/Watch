import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';

class CombineDetailAndWatch {
  MovieDetails movieDetails;
  MovieWatch movieWatch;

  CombineDetailAndWatch({required this.movieDetails, required this.movieWatch});
}
