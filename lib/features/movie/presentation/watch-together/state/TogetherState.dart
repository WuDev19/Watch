import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';

class TogetherState extends Equatable {
  final RoomWatching? roomWatching;
  final bool roomDeleted;

  const TogetherState({this.roomWatching, this.roomDeleted = false});

  TogetherState copyWith({RoomWatching? roomWatching, bool? roomDeleted}) {
    return TogetherState(
      roomWatching: roomWatching ?? this.roomWatching,
      roomDeleted: roomDeleted ?? this.roomDeleted,
    );
  }

  @override
  List<Object?> get props => [roomWatching, roomDeleted];
}
