import 'Pagination.dart';

class Params {
  Pagination? pagination;

  Params({this.pagination});

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    pagination: json["pagination"] != null
        ? Pagination.fromJson(json["pagination"])
        : null,
  );

  Map<String, dynamic> toJson() => {"pagination": pagination?.toJson()};
}
