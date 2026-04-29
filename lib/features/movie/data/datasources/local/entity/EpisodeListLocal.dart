import 'package:isar_community/isar.dart';
part 'EpisodeListLocal.g.dart';

@embedded
class EpisodeListLocal {
  late String name;
  late String filename;
  late String linkM3U8;

  @override
  String toString() {
    return 'EpisodeListLocal{name: $name, filename: $filename, linkM3U8: $linkM3U8}';
  }
}