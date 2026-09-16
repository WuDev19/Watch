import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/AcceptInvitationUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/SkipInvitationUseCase.dart';
import 'package:movie_app/features/movie/presentation/shared_management/state/RoomInviteState.dart';

import '../../../domain/models/RoomInvited.dart';
import '../../../domain/usecases/WatchingRoomInvitedUseCase.dart';

@injectable
class RoomInvitationManagement extends Cubit<RoomInviteState> {
  final WatchingRoomInvitedUseCase _watchingRoomInvitedUseCase;
  final AcceptInvitationUseCase _acceptInvitationUseCase;
  final SkipInvitationUseCase _skipInvitationUseCase;
  StreamSubscription<List<RoomInvited>>? _listenInvite;

  RoomInvitationManagement(
    this._watchingRoomInvitedUseCase,
    this._acceptInvitationUseCase,
    this._skipInvitationUseCase,
  ) : super(const RoomInviteState());

  void watchingRoomInvited() {
    _listenInvite?.cancel();
    _listenInvite = _watchingRoomInvitedUseCase.watchingRoomInvited().listen((
      roomInvited,
    ) {
      final sorted = [...roomInvited]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(state.copyWith(roomInvited: sorted));
    });
  }

  Future<bool> skipInvitation(String roomId) async {
    try {
      await _skipInvitationUseCase.execute(roomId);
      _removeInviteFromState(roomId);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> acceptInvitation(String roomId) async {
    try {
      await _acceptInvitationUseCase.execute(roomId);
      _removeInviteFromState(roomId);
      return true;
    } catch (_) {
      return false;
    }
  }

  void _removeInviteFromState(String roomId) {
    final updated = state.roomInvited.where((e) => e.roomId != roomId).toList();
    emit(state.copyWith(roomInvited: updated));
  }

  @override
  Future<void> close() {
    _listenInvite?.cancel();
    return super.close();
  }
}
