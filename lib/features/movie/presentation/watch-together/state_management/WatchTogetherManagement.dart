import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';
import 'package:movie_app/features/movie/domain/usecases/UpdateRoomUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/WatchingRoomChangeUseCase.dart';
import 'package:movie_app/features/movie/presentation/watch-together/state/TogetherState.dart';

import '../../../domain/models/MovieHistoryModel.dart';
import '../../../domain/models/RoomUpdate.dart';
import '../../../domain/usecases/DeleteRoomUseCase.dart';
import '../../../domain/usecases/GetRoomWatchingUseCase.dart';
import '../../../domain/usecases/SaveMovieHistoryUseCase.dart';

@injectable
class WatchTogetherManagement extends Cubit<TogetherState> {
  final SaveMovieHistoryUseCase _saveMovieHistoryUseCase;
  final GetRoomWatchingUseCase _getRoomWatchingUseCase;
  final WatchingRoomChangeUseCase _watchingRoomChangeUseCase;
  final UpdateRoomUseCase _updateRoomUseCase;
  final DeleteRoomUseCase _deleteRoomUseCase;
  StreamSubscription<RoomWatching?>? _listenMovie;

  WatchTogetherManagement(
    this._saveMovieHistoryUseCase,
    this._getRoomWatchingUseCase,
    this._watchingRoomChangeUseCase,
    this._updateRoomUseCase,
    this._deleteRoomUseCase,
  ) : super(TogetherState());

  void saveMovieHistory(MovieHistoryModel model) async {
    await _saveMovieHistoryUseCase.execute(model);
  }

  Future<bool> checkRoomWatching(String roomId) =>
      _getRoomWatchingUseCase.execute(roomId);

  void watching(String roomId) {
    _listenMovie?.cancel();
    _listenMovie = _watchingRoomChangeUseCase.watching(roomId).listen((room) {
      if(room == null){
        emit(state.copyWith(roomWatching: null, roomDeleted: true));
      }
      else {
        emit(state.copyWith(roomWatching: room));
      }
    });
  }

  void updateRoom({
    required String roomId,
    String? movieUrl,
    num? currentTime,
    num? playbackRate,
    bool? isPlaying,
  }) async {
    final roomUpdate = RoomUpdate(
      roomId: roomId,
      movieUrl: movieUrl,
      currentTime: currentTime,
      playbackRate: playbackRate,
      playing: isPlaying,
    );
    await _updateRoomUseCase.execute(roomUpdate);
  }

  Future<void> deleteRoom(String roomId) => _deleteRoomUseCase.execute(roomId);

  @override
  Future<void> close() {
    _listenMovie?.cancel();
    return super.close();
  }
}
