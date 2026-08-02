import 'package:equatable/equatable.dart';

class ActionCommentState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool isPost;

  const ActionCommentState({
    this.isLoading = false,
    this.error,
    this.isPost = true,
  });

  ActionCommentState copyWith({bool? isLoading, String? error, bool? isPost}) {
    return ActionCommentState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isPost: isPost ?? this.isPost,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, isPost];
}
