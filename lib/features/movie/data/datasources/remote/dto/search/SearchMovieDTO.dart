import '../Tmdb.dart';

class SearchMovieDto {
  String name;
  String originName;
  String slug;
  String? thumbUrl;
  String? posterUrl;
  int year;
  Tmdb tmdb;

  SearchMovieDto({
    required this.name,
    required this.originName,
    required this.slug,
    required this.thumbUrl,
    required this.posterUrl,
    required this.year,
    required this.tmdb,
  });

  factory SearchMovieDto.fromJson(Map<String, dynamic> json) => SearchMovieDto(
    name: json["name"],
    originName: json["origin_name"],
    slug: json["slug"],
    thumbUrl: json["thumb_url"],
    posterUrl: json["poster_url"],
    year: json["year"],
    tmdb: Tmdb.fromJson(json["tmdb"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "origin_name": originName,
    "slug": slug,
    "thumb_url": thumbUrl,
    "poster_url": posterUrl,
    "year": year,
    "tmdb": tmdb.toJson(),
  };

}
