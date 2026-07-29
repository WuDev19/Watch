import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/auth/domain/usecases/CheckLoginUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/DeleteListFavoriteMovieUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/DeleteMovieHistoryUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMovieWatchingUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMyFavoriteMovieUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetWatchedMovieUseCase.dart';
import 'package:movie_app/features/movie/presentation/setting/state/SettingState.dart';
import 'package:movie_app/utils/constants.dart';

import '../../../../auth/domain/usecases/LogoutUseCase.dart';

@injectable
class SettingScreenManagement extends Cubit<SettingState> {
  final GetMyFavoriteMovieUseCase _getMyFavoriteMovieUseCase;
  final GetMovieWatchingUseCase _getMovieWatchingUseCase;
  final GetWatchedMovieUseCase _getWatchedMovieUseCase;
  final DeleteListFavoriteMovieUseCase _deleteListFavoriteMovieUseCase;
  final DeleteMovieHistoryUseCase _deleteMovieHistoryUseCase;
  final CheckLoginUseCase _checkLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  SettingScreenManagement(
    this._getMyFavoriteMovieUseCase,
    this._getMovieWatchingUseCase,
    this._getWatchedMovieUseCase,
    this._deleteListFavoriteMovieUseCase,
    this._deleteMovieHistoryUseCase,
    this._checkLoginUseCase,
    this._logoutUseCase,
  ) : super(SettingState());

  void getMyFavoriteMovie(bool isRefresh) async {
    if (!isRefresh) {
      if (state.favoriteLoading || state.isFavoriteLast) return;
    }
    final nextPage = isRefresh ? 0 : state.currentPageFavorite + 1;
    emit(
      state.copyWith(
        favoriteMovies: isRefresh ? const [] : state.favoriteMovies,
        favoriteLoading: true,
      ),
    );
    try {
      final result = await _getMyFavoriteMovieUseCase.execute(
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          favoriteMovies: isRefresh
              ? result
              : [...state.favoriteMovies, ...result],
          favoriteLoading: false,
          currentPageFavorite: nextPage,
          isFavoriteLast: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(favoriteError: e.toString(), favoriteLoading: false));
    }
  }

  void getWatchingMovie(bool isRefresh) async {
    if (!isRefresh) {
      if (state.watchingLoading || state.isWatchingLast) return;
    }
    final nextPage = isRefresh ? 0 : state.currentPageWatching + 1;
    emit(
      state.copyWith(
        watchingMovies: isRefresh ? const [] : state.watchingMovies,
        watchingLoading: true,
      ),
    );
    try {
      final result = await _getMovieWatchingUseCase.execute(
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          watchingMovies: isRefresh
              ? result
              : [...state.watchingMovies, ...result],
          watchingLoading: false,
          currentPageWatching: nextPage,
          isWatchingLast: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(watchingError: e.toString(), watchingLoading: false));
    }
  }

  void getWatchedMovie(bool isRefresh) async {
    if (!isRefresh) {
      if (state.watchedLoading || state.isWatchedLast) return;
    }
    final nextPage = isRefresh ? 0 : state.currentPageWatched + 1;
    emit(
      state.copyWith(
        watchedMovies: isRefresh ? const [] : state.watchedMovies,
        watchedLoading: true,
      ),
    );
    try {
      final result = await _getWatchedMovieUseCase.execute(
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          watchedMovies: isRefresh
              ? result
              : [...state.watchedMovies, ...result],
          watchedLoading: false,
          currentPageWatched: nextPage,
          isWatchedLast: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(state.copyWith(watchedError: e.toString(), watchedLoading: false));
    }
  }

  Future<void> deleteFavoriteMovie(List<String> slug) =>
      _deleteListFavoriteMovieUseCase.execute(slug);

  Future<void> deleteHistoryMovie(List<String> slug) =>
      _deleteMovieHistoryUseCase.execute(slug);

  Future<bool> checkLogin() => _checkLoginUseCase.execute();

  Future<bool> logout() => _logoutUseCase.execute();
}
