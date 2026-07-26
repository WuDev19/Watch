class SignUpRequest {
  String email;
  String password;
  String name;
  bool isActive;

  SignUpRequest(this.email, this.password, this.name, this.isActive);
}