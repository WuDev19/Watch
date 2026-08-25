import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/RoomWatching.dart';
import 'package:movie_app/features/movie/domain/usecases/WatchingRoomChangeUseCase.dart';
import 'package:movie_app/features/movie/presentation/watch-together/state/TogetherState.dart';

import '../../../domain/models/MovieHistoryModel.dart';
import '../../../domain/usecases/GetRoomWatchingUseCase.dart';
import '../../../domain/usecases/SaveMovieHistoryUseCase.dart';

@injectable
class WatchTogetherManagement extends Cubit<TogetherState> {
  final SaveMovieHistoryUseCase _saveMovieHistoryUseCase;
  final GetRoomWatchingUseCase _getRoomWatchingUseCase;
  final WatchingRoomChangeUseCase _watchingRoomChangeUseCase;
  StreamSubscription<RoomWatching?>? _listenMovie;

  WatchTogetherManagement(
    this._saveMovieHistoryUseCase,
    this._getRoomWatchingUseCase,
    this._watchingRoomChangeUseCase,
  ) : super(TogetherState());

  void saveMovieHistory(MovieHistoryModel model) async {
    await _saveMovieHistoryUseCase.execute(model);
  }

  Future<bool> getRoomWatching(String roomId) =>
      _getRoomWatchingUseCase.execute(roomId);

  void watching(String roomId) {
    _listenMovie?.cancel();
    _listenMovie = _watchingRoomChangeUseCase.watching(roomId).listen((room) {
      emit(state.copyWith(roomWatching: room));
    });
  }

  @override
  Future<void> close() {
    _listenMovie?.cancel();
    return super.close();
  }
}
