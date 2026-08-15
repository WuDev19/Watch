import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';

class GetRoomState extends Equatable {
  final RoomWatching? roomWatching;
  final bool isLoading;
  final String? error;

  const GetRoomState({this.roomWatching, this.isLoading = false, this.error});

  GetRoomState copyWith({
    RoomWatching? roomWatching,
    bool? isLoading,
    String? error,
  }) {
    return GetRoomState(
      roomWatching: roomWatching ?? this.roomWatching,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [roomWatching, isLoading, error];
}
