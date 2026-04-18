import 'EpisodeList.dart';

class Episode {
  String serverName;
  List<EpisodeList> episodeList;
  bool isSelected;

  Episode({
    required this.serverName,
    required this.episodeList,
    required this.isSelected,
  });

  @override
  String toString() {
    return 'Episode{serverName: $serverName, episodeList: $episodeList}';
  }
}
