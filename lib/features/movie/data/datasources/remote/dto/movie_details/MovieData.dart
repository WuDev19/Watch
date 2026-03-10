import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/MovieDetailsDTO.dart';

class MovieData {
  MovieDetailsDTO item;

  MovieData({required this.item});

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      MovieData(item: MovieDetailsDTO.fromJson(json["item"]));

  Map<String, dynamic> toJson() => {"item": item.toJson()};
}
