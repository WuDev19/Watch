import 'package:equatable/equatable.dart';

import '../../../domain/models/CommentTotal.dart';

class GetCommentState extends Equatable {
  final CommentTotal? commentTotal;
  final bool isLoading;
  final String? error;

  const GetCommentState({
    this.commentTotal,
    this.isLoading = false,
    this.error,
  });

  GetCommentState copyWith({
    CommentTotal? commentTotal,
    bool? isLoading,
    String? error,
  }) {
    return GetCommentState(
      commentTotal: commentTotal ?? this.commentTotal,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [commentTotal, isLoading, error];
}
