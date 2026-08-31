import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/MemberRequest.dart';

class CreateRoomRequest {
  String movieName;
  String roomId;
  bool isPlaying;
  num playbackRate;
  String movieUrl;
  num currentTime;
  String hostId;
  List<MemberRequest> reserveMembers;

  CreateRoomRequest({
    required this.movieName,
    required this.roomId,
    required this.isPlaying,
    required this.playbackRate,
    required this.movieUrl,
    required this.currentTime,
    required this.hostId,
    required this.reserveMembers,
  });

  Map<String, dynamic> toJson() => {
    "movieName": movieName,
    "roomId": roomId,
    "isPlaying": isPlaying,
    "playbackRate": playbackRate,
    "movieUrl": movieUrl,
    "currentTime": currentTime,
    "hostId": hostId,
    "reserveMembers": reserveMembers.map((e) => e.toJson()).toList(),
  };
}
