import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/SignUpRequest.dart';

import '../../../../domain/models/SignUpModel.dart';

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
