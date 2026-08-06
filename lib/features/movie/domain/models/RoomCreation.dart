import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';

class RoomCreation {
  CombineDetailAndWatch combine;
  List<RoomMember> members;

  RoomCreation({required this.combine, required this.members});
}
