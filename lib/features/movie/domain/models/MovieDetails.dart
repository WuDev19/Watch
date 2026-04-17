import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/Episode.dart';

class MovieDetails {
  double movieStar;
  String releaseDate;
  String name;
  String slug;
  String originName;
  String content;
  String type;
  String status;
  String thumbUrl;
  String posterUrl;
  String trailerUrl;
  String time;
  String episodeCurrent;
  String episodeTotal;
  String quality;
  String lang;
  int year;
  int view;
  List<CategoryModel> category;
  String country;
  List<Episode> episodes;
  List<String> alternativeNames;

  MovieDetails({
    required this.movieStar,
    required this.releaseDate,
    required this.name,
    required this.slug,
    required this.originName,
    required this.content,
    required this.type,
    required this.status,
    required this.thumbUrl,
    required this.posterUrl,
    required this.trailerUrl,
    required this.time,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.year,
    required this.view,
    required this.category,
    required this.country,
    required this.episodes,
    required this.alternativeNames,
  });

  @override
  String toString() {
    return 'MovieDetails{category: $category}';
  }
}
