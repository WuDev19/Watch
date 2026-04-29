import 'package:isar_community/isar.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/EpisodeListLocal.dart';
part 'PageEpisodeLocal.g.dart';

@embedded
class PageEpisodeLocal {
  late int page;
  late List<EpisodeListLocal> episodeList;

  @override
  String toString() {
    return 'PageEpisodeLocal{page: $page, episodeList: $episodeList}';
  }
}