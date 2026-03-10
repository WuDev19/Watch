class EpisodeListDTO {
  String name;
  String slug;
  String filename;
  String linkM3U8;

  EpisodeListDTO({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkM3U8,
  });

  factory EpisodeListDTO.fromJson(Map<String, dynamic> json) => EpisodeListDTO(
    name: json["name"],
    slug: json["slug"],
    filename: json["filename"],
    linkM3U8: json["link_m3u8"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "filename": filename,
    "link_m3u8": linkM3U8,
  };
}