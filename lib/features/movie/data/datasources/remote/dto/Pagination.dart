class Pagination {
  int totalItems;

  Pagination({required this.totalItems});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      Pagination(totalItems: json["totalItems"]);

  Map<String, dynamic> toJson() => {"totalItems": totalItems};
}
