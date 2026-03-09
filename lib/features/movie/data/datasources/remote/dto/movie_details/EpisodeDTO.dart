import 'package:movie_app/features/movie/data/datasources/remote/dto/movie_details/EpisodeList.dart';

class EpisodeDTO {
  String serverName;
  List<EpisodeList> serverData;

  EpisodeDTO({required this.serverName, required this.serverData});

  factory EpisodeDTO.fromJson(Map<String, dynamic> json) => EpisodeDTO(
    serverName: json["server_name"],
    serverData: List<EpisodeList>.from(
      json["server_data"].map((x) => EpisodeDTO.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "server_name": serverName,
    "server_data": List<dynamic>.from(serverData.map((x) => x.toJson())),
  };
}
