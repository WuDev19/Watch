import '../../../../domain/models/SignUpModel.dart';
import '../dto/request/SignUpRequest.dart';

class AuthMapper {
  AuthMapper._();

  static SignUpRequest mapToSignUpRequest(SignUpModel model) {
    return SignUpRequest(
      model.email,
      model.password,
      model.name,
      model.isActive,
    );
  }
}
