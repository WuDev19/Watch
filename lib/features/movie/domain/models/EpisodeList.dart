import 'package:equatable/equatable.dart';

class EpisodeList extends Equatable {
  final String name;
  final String slug;
  final String filename;
  final String linkM3U8;

  const EpisodeList({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkM3U8,
  });

  @override
  String toString() {
    return 'EpisodeList{name: $name}';
  }

  @override
  List<Object?> get props => [name, slug, filename, linkM3U8];
}
