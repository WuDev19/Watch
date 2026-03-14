class PeopleDTO {
  String name;
  String originalName;
  String profilePath;

  PeopleDTO({
    required this.name,
    required this.originalName,
    required this.profilePath,
  });

  factory PeopleDTO.fromJson(Map<String, dynamic> json) => PeopleDTO(
    name: json["name"],
    originalName: json["original_name"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "original_name": originalName,
    "profile_path": profilePath,
  };
}
