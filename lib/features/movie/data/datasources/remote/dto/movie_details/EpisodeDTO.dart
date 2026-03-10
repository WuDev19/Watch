import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/EpisodeListDTO.dart';

class EpisodeDTO {
  String serverName;
  List<EpisodeListDTO> episodeList;

  EpisodeDTO({required this.serverName, required this.episodeList});

  factory EpisodeDTO.fromJson(Map<String, dynamic> json) => EpisodeDTO(
    serverName: json["server_name"],
    episodeList: List<EpisodeListDTO>.from(
      json["server_data"].map((x) => EpisodeListDTO.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "server_name": serverName,
    "server_data": List<dynamic>.from(episodeList.map((x) => x.toJson())),
  };
}
