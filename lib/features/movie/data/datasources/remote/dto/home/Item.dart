import '../Tmdb.dart';

class Item {
  Tmdb tmdb;
  String name;
  String slug;
  String originName;
  String thumbUrl;

  Item({
    required this.tmdb,
    required this.name,
    required this.slug,
    required this.originName,
    required this.thumbUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    tmdb: Tmdb.fromJson(json["tmdb"]),
    name: json["name"],
    slug: json["slug"],
    originName: json["origin_name"],
    thumbUrl: json["thumb_url"],
  );

  Map<String, dynamic> toJson() => {
    "tmdb": tmdb.toJson(),
    "name": name,
    "slug": slug,
    "origin_name": originName,
    "thumb_url": thumbUrl,
  };

  @override
  String toString() {
    return 'Item{tmdb: $tmdb, name: $name, slug: $slug, originName: $originName, thumbUrl: $thumbUrl}';
  }

}
