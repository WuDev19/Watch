class EpisodeList {
  String name;
  String filename;
  String linkM3U8;

  EpisodeList({
    required this.name,
    required this.filename,
    required this.linkM3U8,
  });

  @override
  String toString() {
    return 'EpisodeList{name: $name}';
  }
}
