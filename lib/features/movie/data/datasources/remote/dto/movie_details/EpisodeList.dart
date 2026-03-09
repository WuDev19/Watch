class EpisodeList {
  String name;
  String slug;
  String filename;
  String linkEmbed;
  String linkM3U8;

  EpisodeList({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3U8,
  });

  factory EpisodeList.fromJson(Map<String, dynamic> json) => EpisodeList(
    name: json["name"],
    slug: json["slug"],
    filename: json["filename"],
    linkEmbed: json["link_embed"],
    linkM3U8: json["link_m3u8"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "filename": filename,
    "link_embed": linkEmbed,
    "link_m3u8": linkM3U8,
  };
}