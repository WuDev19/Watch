import 'Data.dart';

class MovieResponse<T> {
  Data<T> data;

  MovieResponse({required this.data});

  factory MovieResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> jsonT) fromJsonT,
  ) => MovieResponse(data: Data<T>.fromJson(json["data"], fromJsonT));

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T itemT) toJsonT) =>
      {"data": data.toJson(toJsonT)};

  @override
  String toString() {
    return 'MovieResponse{data: $data}';
  }
}
