import 'package:movie_app/features/movie/data/datasources/third-source/dto/response/MemberResponse.dart';

class RoomResponse {
  final String movieName;
  final String roomId;
  final bool isPlaying;
  final num playbackRate;
  final String movieUrl;
  final num currentTime;
  final String hostId;
  final List<MemberResponse> members;

  const RoomResponse({
    required this.movieName,
    required this.roomId,
    required this.isPlaying,
    required this.playbackRate,
    required this.movieUrl,
    required this.currentTime,
    required this.hostId,
    required this.members,
  });

  static RoomResponse? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return RoomResponse(
      movieName: json["movieName"] as String? ?? "",
      roomId: json["roomId"] as String? ?? "",
      isPlaying: json["isPlaying"] as bool? ?? false,
      playbackRate: (json["playbackRate"] as num?)?.toDouble() ?? 1.0,
      movieUrl: json["movieUrl"] as String? ?? "",
      currentTime: (json["currentTime"] as num?)?.toDouble() ?? 0,
      hostId: json["hostId"] as String? ?? "",
      members: json["members"] == null
          ? []
          : List<MemberResponse>.from(
        (json["members"] as List).map((x) => MemberResponse.fromJson(x)),
      ),
    );
  }

}
