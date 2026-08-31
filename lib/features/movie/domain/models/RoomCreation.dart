import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';

class RoomCreation {
  CombineDetailAndWatch? combine;
  List<RoomMember>? reserveMembers;
  bool isHost;
  String roomId;

  RoomCreation({
    this.combine,
    this.reserveMembers,
    required this.isHost,
    required this.roomId,
  });
}
