import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/presentation/shared_management/state/RoomInviteState.dart';

import '../../../domain/models/RoomInvited.dart';
import '../../../domain/usecases/WatchingRoomInvitedUseCase.dart';

@injectable
class RoomInvitationManagement extends Cubit<RoomInviteState> {
  final WatchingRoomInvitedUseCase _watchingRoomInvitedUseCase;
  StreamSubscription<List<RoomInvited>>? _listenInvite;

  RoomInvitationManagement(this._watchingRoomInvitedUseCase)
    : super(const RoomInviteState());

  void watchingRoomInvited() {
    _listenInvite?.cancel();
    _listenInvite = _watchingRoomInvitedUseCase.watchingRoomInvited().listen((
      roomInvited,
    ) {
      emit(state.copyWith(roomInvited: roomInvited));
    });
  }
}
