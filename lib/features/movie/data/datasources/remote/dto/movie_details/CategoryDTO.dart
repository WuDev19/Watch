class CategoryDTO {
  String id;
  String name;
  String slug;

  CategoryDTO({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) => CategoryDTO(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
