import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/GetLastWatchedMovieUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/HomePageMovieUseCase.dart';
import 'package:movie_app/features/movie/presentation/home/state/HomeState.dart';

@injectable
class HomeBloc extends Cubit<HomeState> {
  final HomePageMovieUseCase _homePageMovieUseCase;
  final GetLastWatchedMovieUseCase _getLastWatchedMovieUseCase;

  HomeBloc(this._homePageMovieUseCase, this._getLastWatchedMovieUseCase)
    : super(HomeState());

  void getHomePageMovie() async {
    emit(state.copyWith(isLoading: true, movies: [], error: null));
    try {
      final data = await _homePageMovieUseCase.execute();
      emit(state.copyWith(movies: data, isLoading: false, error: null));
    } catch (e) {
      print(e);
      emit(state.copyWith(error: e.toString(), isLoading: false, movies: []));
    }
  }

  void getLastMovieWatched() async {
    emit(state.copyWith(isLoadingMovieWatched: true));
    try {
      final result = await _getLastWatchedMovieUseCase.execute();
      emit(state.copyWith(movieWatched: result, isLoadingMovieWatched: false));
    } catch (e) {
      emit(state.copyWith(errorMovieWatched: e.toString()));
    }
  }
}
