import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/CreatedDTO.dart';
import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/EpisodeDTO.dart';

import '../Tmdb.dart';
import 'CategoryDTO.dart';

class MovieDetailsDTO {
  Tmdb tmdb;
  CreatedDTO created;
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
  List<CategoryDTO> category;
  List<CategoryDTO> country;
  List<EpisodeDTO> episodes;
  List<String> alternativeNames;

  MovieDetailsDTO({
    required this.tmdb,
    required this.created,
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

  factory MovieDetailsDTO.fromJson(Map<String, dynamic> json) =>
      MovieDetailsDTO(
        tmdb: Tmdb.fromJson(json["tmdb"]),
        created: CreatedDTO.fromJson(json["created"]),
        name: json["name"],
        slug: json["slug"],
        originName: json["origin_name"],
        content: json["content"],
        type: json["type"],
        status: json["status"],
        thumbUrl: json["thumb_url"],
        posterUrl: json["poster_url"],
        trailerUrl: json["trailer_url"],
        time: json["time"],
        episodeCurrent: json["episode_current"],
        episodeTotal: json["episode_total"],
        quality: json["quality"],
        lang: json["lang"],
        year: json["year"],
        view: json["view"],
        category: List<CategoryDTO>.from(
          json["category"].map((x) => CategoryDTO.fromJson(x)),
        ),
        country: List<CategoryDTO>.from(
          json["country"].map((x) => CategoryDTO.fromJson(x)),
        ),
        episodes: List<EpisodeDTO>.from(
          json["episodes"].map((x) => EpisodeDTO.fromJson(x)),
        ),
        alternativeNames: List<String>.from(
          json["alternative_names"].map((x) => x),
        ),
      );

  Map<String, dynamic> toJson() => {
    "tmdb": tmdb.toJson(),
    "created": created.toJson(),
    "name": name,
    "slug": slug,
    "origin_name": originName,
    "content": content,
    "type": type,
    "status": status,
    "thumb_url": thumbUrl,
    "poster_url": posterUrl,
    "trailer_url": trailerUrl,
    "time": time,
    "episode_current": episodeCurrent,
    "episode_total": episodeTotal,
    "quality": quality,
    "lang": lang,
    "year": year,
    "view": view,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "country": List<dynamic>.from(country.map((x) => x.toJson())),
    "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    "alternative_names": List<dynamic>.from(alternativeNames.map((x) => x)),
  };
}
