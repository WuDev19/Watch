class ProfileResponse {
  String? email;
  String? name;
  String? avt;

  ProfileResponse(this.email, this.name, this.avt);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(json["email"], json["name"], json["avt"]);
  }
}
