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

  factory RoomResponse.fromJson(Map<String, dynamic> json) => RoomResponse(
    movieName: json["movieName"],
    roomId: json["roomId"],
    isPlaying: json["isPlaying"],
    playbackRate: json["playbackRate"],
    movieUrl: json["movieUrl"],
    currentTime: json["currentTime"],
    hostId: json["hostId"],
    members: List<MemberResponse>.from(
      json["members"].map((x) => MemberResponse.fromJson(x)),
    ),
  );
}
