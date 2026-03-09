import 'Params.dart';

class Data<T> {
  List<T> items;
  Params? params;

  Data({required this.items, this.params});

  factory Data.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> jsonT) fromJsonT,
  ) => Data(
    items: List<T>.from(json["items"].map((x) => fromJsonT(x))),
    params: json["params"] != null ? Params.fromJson(json["params"]) : null,
  );

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T itemT) toJsonT) =>
      {
        "items": List<dynamic>.from(items.map((x) => toJsonT(x))),
        "params": params?.toJson(),
      };

  @override
  String toString() {
    return 'Data{items: $items}';
  }
}
