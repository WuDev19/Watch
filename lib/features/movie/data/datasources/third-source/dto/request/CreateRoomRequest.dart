import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/features/movie/data/datasources/third-source/dto/request/MemberRequest.dart';

class CreateRoomRequest {
  String movieName;
  String roomId;
  bool isPlaying;
  num playbackRate;
  String movieUrl;
  num currentTime;
  String hostId;
  String hostName;
  String moviePoster;
  List<MemberRequest> reserveMembers;

  CreateRoomRequest({
    required this.movieName,
    required this.roomId,
    required this.isPlaying,
    required this.playbackRate,
    required this.movieUrl,
    required this.currentTime,
    required this.hostId,
    required this.hostName,
    required this.moviePoster,
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
    "hostName": hostName,
    "moviePoster": moviePoster,
    "reserveMembers": reserveMembers.map((e) => e.toJson()).toList(),
    "createdAt": Timestamp.now(),
  };
}
