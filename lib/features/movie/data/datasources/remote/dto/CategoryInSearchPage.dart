class CategoryInSearchPage {
  String id;
  String name;
  String slug;

  CategoryInSearchPage({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CategoryInSearchPage.fromJson(Map<String, dynamic> json) =>
      CategoryInSearchPage(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "slug": slug};

}
