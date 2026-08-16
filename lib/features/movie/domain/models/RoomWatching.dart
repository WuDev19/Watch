import 'package:movie_app/features/movie/domain/models/RoomMember.dart';

class RoomWatching {
  final String movieName;
  final String roomId;
  final bool isPlaying;
  final num playbackRate;
  final String movieUrl;
  final num currentTime;
  final String hostId;
  final List<RoomMember> members;

  const RoomWatching({
    required this.movieName,
    required this.roomId,
    required this.isPlaying,
    required this.playbackRate,
    required this.movieUrl,
    required this.currentTime,
    required this.hostId,
    required this.members,
  });
}
