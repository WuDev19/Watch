import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';

class TogetherState extends Equatable {
  final RoomWatching? roomWatching;

  const TogetherState({this.roomWatching});

  TogetherState copyWith({RoomWatching? roomWatching}) {
    return TogetherState(roomWatching: roomWatching ?? this.roomWatching);
  }

  @override
  List<Object?> get props => [roomWatching];
}
