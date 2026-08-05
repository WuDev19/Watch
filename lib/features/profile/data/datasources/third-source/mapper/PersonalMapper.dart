import 'package:movie_app/features/profile/domain/models/Profile.dart';

import '../dto/response/ProfileResponse.dart';

class PersonalMapper {
  PersonalMapper._();

  static Profile mapToProfile(ProfileResponse response) {
    return Profile(response.name, response.email, response.avt);
  }
}
