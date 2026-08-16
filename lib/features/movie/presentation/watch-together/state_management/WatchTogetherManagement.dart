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
  late final StreamSubscription<RoomWatching?>? _listenMovie;

  WatchTogetherManagement(
    this._saveMovieHistoryUseCase,
    this._getRoomWatchingUseCase,
    this._watchingRoomChangeUseCase,
  ) : super(TogetherState());

  void saveMovieHistory(MovieHistoryModel model) async {
    await _saveMovieHistoryUseCase.execute(model);
  }

  void getRoomWatching(String roomId) async {
    emit(
      state.copyWith(
        getRoomState: state.getRoomState.copyWith(isLoading: true),
      ),
    );
    try {
      final result = await _getRoomWatchingUseCase.execute(roomId);
      emit(
        state.copyWith(
          getRoomState: state.getRoomState.copyWith(
            roomWatching: result,
            isLoading: false,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getRoomState: state.getRoomState.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        ),
      );
    }
  }

  void watching(String roomId) {
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
