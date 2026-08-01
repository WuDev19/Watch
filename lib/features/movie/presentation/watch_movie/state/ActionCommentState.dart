import 'package:equatable/equatable.dart';

class ActionCommentState extends Equatable {
  final bool isLoading;
  final String? error;

  const ActionCommentState({this.isLoading = false, this.error});

  ActionCommentState copyWith({bool? isLoading, String? error}) {
    return ActionCommentState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, error];
}
