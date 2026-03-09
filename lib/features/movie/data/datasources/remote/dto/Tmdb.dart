class Tmdb {
  double voteAverage;

  Tmdb({
    required this.voteAverage,
  });

  factory Tmdb.fromJson(Map<String, dynamic> json) => Tmdb(
    voteAverage: json["vote_average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "vote_average": voteAverage,
  };

}