import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/RoomInvited.dart';

class RoomInviteState extends Equatable {
  final List<RoomInvited> roomInvited;

  const RoomInviteState({this.roomInvited = const []});

  RoomInviteState copyWith({List<RoomInvited>? roomInvited}) {
    return RoomInviteState(roomInvited: roomInvited ?? this.roomInvited);
  }

  @override
  List<Object?> get props => [roomInvited];
}
