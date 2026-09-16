class Profile {
  String? name;
  String? email;
  String? avt;

  Profile(this.name, this.email, this.avt);

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(json["name"], json["email"], json["avt"]);
  }
}
