class Year {
  int year;

  Year({required this.year});

  factory Year.fromJson(Map<String, dynamic> json) {
    return Year(year: json["year"]);
  }

  Map<String, dynamic> toJson() => {"year": year};

}
