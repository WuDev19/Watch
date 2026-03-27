class CategoryOrCountryDTO {
  String id;
  String name;
  String slug;

  CategoryOrCountryDTO({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CategoryOrCountryDTO.fromJson(Map<String, dynamic> json) =>
      CategoryOrCountryDTO(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "slug": slug};

}
