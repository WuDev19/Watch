import 'EpisodeList.dart';

class Episode {
  String serverName;
  Map<int, List<EpisodeList>> paginationEpisode;
  bool isSelected;

  Episode({
    required this.serverName,
    required this.paginationEpisode,
    required this.isSelected,
  });

  @override
  String toString() {
    return 'Episode{serverName: $serverName, episodeList: $paginationEpisode}';
  }
}
