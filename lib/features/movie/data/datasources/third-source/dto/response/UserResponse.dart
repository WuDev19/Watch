class UserResponse {
  String? userId;
  String? avt;
  String? name;

  UserResponse(this.userId, this.avt, this.name);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(json["userId"], json["avt"], json["name"]);
  }
}