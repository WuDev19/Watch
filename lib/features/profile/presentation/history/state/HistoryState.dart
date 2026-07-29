import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';

class HistoryState extends Equatable {
  final List<MovieWatching> history;
  final bool isLoadingHistory;
  final String? errorHistory;
  final int currentPageHistory;
  final bool isLastHistory;

  const HistoryState({
    this.history = const [],
    this.isLoadingHistory = false,
    this.errorHistory,
    this.currentPageHistory = -1,
    this.isLastHistory = false,
  });

  HistoryState copyWith({
    List<MovieWatching>? history,
    bool? isLoadingHistory,
    String? errorHistory,
    int? currentPageHistory,
    bool? isLastHistory,
  }) {
    return HistoryState(
      history: history ?? this.history,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      errorHistory: errorHistory ?? this.errorHistory,
      currentPageHistory: currentPageHistory ?? this.currentPageHistory,
      isLastHistory: isLastHistory ?? this.isLastHistory,
    );
  }

  @override
  List<Object?> get props => [
    history,
    isLoadingHistory,
    errorHistory,
    currentPageHistory,
    isLastHistory,
  ];
}
