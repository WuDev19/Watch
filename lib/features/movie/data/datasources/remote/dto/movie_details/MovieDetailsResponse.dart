import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/MovieData.dart';

class MovieDetailsResponse {
  MovieData data;

  MovieDetailsResponse({required this.data});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailsResponse(data: MovieData.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"data": data.toJson()};
}
