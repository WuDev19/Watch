class ProfileSizeDTO {
  String w185;

  ProfileSizeDTO({required this.w185});

  factory ProfileSizeDTO.fromJson(Map<String, dynamic> json) =>
      ProfileSizeDTO(w185: json["w185"]);

  Map<String, dynamic> toJson() => {"w185": w185};
}
