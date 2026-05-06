import 'package:isar_community/isar.dart';

part 'FavoriteMovie.g.dart';

@collection
class FavoriteMovie {
  Id id = Isar.autoIncrement;
  String movieName;
  @Index(unique: true, replace: true, type: IndexType.hash)
  String movieSlug;
  String thumbUrl;
  @Index()
  DateTime createdAt;

  FavoriteMovie({
    required this.movieName,
    required this.movieSlug,
    required this.thumbUrl,
    required this.createdAt,
  });
}
