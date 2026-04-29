import 'package:isar_community/isar.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/PageEpisodeLocal.dart';

part 'EpisodeLocal.g.dart';

@embedded
class EpisodeLocal {
  late String serverName;
  late List<PageEpisodeLocal> paginationEpisode;

  @override
  String toString() {
    return 'EpisodeLocal{serverName: $serverName, paginationEpisode: $paginationEpisode';
  }
}
