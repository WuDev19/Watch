import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';

class RoomCreation {
  CombineDetailAndWatch? combine;
  List<RoomMember>? members;
  bool isHost;
  String roomId;

  RoomCreation({
    this.combine,
    this.members,
    required this.isHost,
    required this.roomId,
  });
}
