class MovieDetailsResponse<T> {
  T data;

  MovieDetailsResponse({required this.data});

  factory MovieDetailsResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> jsonT) fromJsonT,
  ) => MovieDetailsResponse(data: fromJsonT(json));

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T item) toJsonT) =>
      {"data": toJsonT(data)};
}
