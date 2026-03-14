class MovieActors {
  String name;
  String originalName;
  String profilePicture;

  MovieActors({
    required this.name,
    required this.originalName,
    required this.profilePicture,
  });

  @override
  String toString() {
    return 'MovieActors{name: $name, originalName: $originalName, profilePicture: $profilePicture}';
  }
}
