import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';
import 'package:movie_app/features/movie/presentation/watch-together/state/GetRoomState.dart';

class TogetherState extends Equatable {
  final GetRoomState getRoomState;
  final RoomWatching? roomWatching;

  const TogetherState({
    this.getRoomState = const GetRoomState(),
    this.roomWatching,
  });

  TogetherState copyWith({
    GetRoomState? getRoomState,
    RoomWatching? roomWatching,
  }) {
    return TogetherState(
      getRoomState: getRoomState ?? this.getRoomState,
      roomWatching: roomWatching ?? this.roomWatching,
    );
  }

  @override
  List<Object?> get props => [getRoomState, roomWatching];
}
