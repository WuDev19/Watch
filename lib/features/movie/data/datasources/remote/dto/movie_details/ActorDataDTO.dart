import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/ProfileSizeDTO.dart';

import 'PeopleDTO.dart';

class ActorDataDTO {
  ProfileSizeDTO profileSizes;
  List<PeopleDTO> peoples;

  ActorDataDTO({required this.profileSizes, required this.peoples});

  factory ActorDataDTO.fromJson(Map<String, dynamic> json) => ActorDataDTO(
    profileSizes: ProfileSizeDTO.fromJson(json["profile_sizes"]),
    peoples: List<PeopleDTO>.from(
      json["peoples"].map((x) => PeopleDTO.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "profile_sizes": profileSizes.toJson(),
    "peoples": List<dynamic>.from(peoples.map((x) => x.toJson())),
  };
}
