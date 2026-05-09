import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMovieWatchingUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMyFavoriteMovieUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetWatchedMovieUseCase.dart';
import 'package:movie_app/features/movie/presentation/setting/state/SettingState.dart';

@injectable
class SettingScreenManagement extends Cubit<SettingState> {
  final GetMyFavoriteMovieUseCase _getMyFavoriteMovieUseCase;
  final GetMovieWatchingUseCase _getMovieWatchingUseCase;
  final GetWatchedMovieUseCase _getWatchedMovieUseCase;

  SettingScreenManagement(
    this._getMyFavoriteMovieUseCase,
    this._getMovieWatchingUseCase,
    this._getWatchedMovieUseCase,
  ) : super(SettingState());

  void getMyFavoriteMovie() async {
    emit(state.copyWith(favoriteLoading: true));
    try {
      final result = await _getMyFavoriteMovieUseCase.execute();
      emit(state.copyWith(favoriteMovies: result, favoriteLoading: false));
    } catch (e) {
      emit(state.copyWith(favoriteError: e.toString(), favoriteLoading: false));
    }
  }

  void getWatchingMovie() async {
    emit(state.copyWith(watchingLoading: true));
    try {
      final result = await _getMovieWatchingUseCase.execute();
      emit(state.copyWith(watchingMovies: result, watchingLoading: false));
    } catch (e) {
      emit(state.copyWith(watchingError: e.toString(), watchingLoading: false));
    }
  }

  void getWatchedMovie() async {
    emit(state.copyWith(watchedLoading: true));
    try {
      final result = await _getWatchedMovieUseCase.execute();
      emit(state.copyWith(watchedMovies: result, watchedLoading: false));
    } catch (e) {
      emit(state.copyWith(watchedError: e.toString(), watchedLoading: false));
    }
  }

}
