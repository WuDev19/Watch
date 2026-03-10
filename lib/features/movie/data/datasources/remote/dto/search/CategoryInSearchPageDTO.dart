class CategoryInSearchPageDTO {
  String id;
  String name;
  String slug;

  CategoryInSearchPageDTO({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CategoryInSearchPageDTO.fromJson(Map<String, dynamic> json) =>
      CategoryInSearchPageDTO(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "slug": slug};

}
