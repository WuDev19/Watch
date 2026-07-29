import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/DeleteMovieHistoryUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/DeleteAllMovieHistoryUseCase.dart';
import 'package:movie_app/utils/constants.dart';

import '../../../domain/usecases/GetMyHistoryUseCase.dart';
import '../../../domain/usecases/SearchMovieHistoryUseCase.dart';
import '../state/HistoryState.dart';

@injectable
class HistoryManagement extends Cubit<HistoryState> {
  final GetMyHistoryUseCase _getMyHistoryUseCase;
  final SearchMovieHistoryUseCase _searchMovieHistoryUseCase;
  final DeleteAllMovieHistoryUseCase _deleteAllMovieHistoryUseCase;
  final DeleteMovieHistoryUseCase _deleteMovieHistoryUseCase;

  HistoryManagement(
    this._getMyHistoryUseCase,
    this._searchMovieHistoryUseCase,
    this._deleteAllMovieHistoryUseCase,
    this._deleteMovieHistoryUseCase,
  ) : super(HistoryState());

  void getMyHistory(bool isRefresh) async {
    if (!isRefresh) {
      if (state.isLoadingHistory || state.isLastHistory) return;
    }
    final nextPage = isRefresh ? 0 : state.currentPageHistory + 1;
    emit(
      state.copyWith(
        history: isRefresh ? const [] : state.history,
        isLoadingHistory: true,
      ),
    );
    try {
      final result = await _getMyHistoryUseCase.execute(
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          history: isRefresh ? result : [...state.history, ...result],
          isLoadingHistory: false,
          currentPageHistory: nextPage,
          isLastHistory: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorHistory: e.toString(), isLoadingHistory: false));
    }
  }

  void searchMovieHistory(String keyword, bool isNewSearch) async {
    if (!isNewSearch) {
      if (state.isLoadingHistory || state.isLastHistory) return;
    }
    final nextPage = isNewSearch ? 0 : state.currentPageHistory + 1;
    emit(
      state.copyWith(
        history: isNewSearch ? const [] : state.history,
        isLoadingHistory: true,
      ),
    );
    try {
      final result = await _searchMovieHistoryUseCase.execute(
        keyword,
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          history: isNewSearch ? result : [...state.history, ...result],
          isLoadingHistory: false,
          currentPageHistory: nextPage,
          isLastHistory: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorHistory: e.toString(), isLoadingHistory: false));
    }
  }

  void deleteAllMovieHistory() async {
    try {
      await _deleteAllMovieHistoryUseCase.execute();
      emit(
        state.copyWith(
          currentPageHistory: -1,
          isLastHistory: false,
          history: [],
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorHistory: e.toString()));
    }
  }

  Future<void> deleteHistoryMovie(List<String> slug) =>
      _deleteMovieHistoryUseCase.execute(slug);
}
