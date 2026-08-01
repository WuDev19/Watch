import 'package:equatable/equatable.dart';

import 'ActionCommentState.dart';
import 'GetCommentState.dart';
import 'SelfState.dart';

class WatchMovieState extends Equatable {
  final SelfState selfState;
  final ActionCommentState actionCommentState;
  final GetCommentState getCommentState;

  const WatchMovieState({
    this.selfState = const SelfState(),
    this.actionCommentState = const ActionCommentState(),
    this.getCommentState = const GetCommentState(),
  });

  WatchMovieState copyWith({
    SelfState? selfState,
    ActionCommentState? actionCommentState,
    GetCommentState? getCommentState,
  }) {
    return WatchMovieState(
      selfState: selfState ?? this.selfState,
      actionCommentState: actionCommentState ?? this.actionCommentState,
      getCommentState: getCommentState ?? this.getCommentState,
    );
  }

  @override
  List<Object?> get props => [selfState, actionCommentState, getCommentState];
}
