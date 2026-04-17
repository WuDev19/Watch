import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMovieActorsUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMovieDetailsInfoUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/SearchMovieAccordingToCategoryUseCase.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/MovieDetailState.dart';

@injectable
class MovieDetailManagement extends Cubit<MovieDetailState> {
  final GetMovieDetailsInfoUseCase _getMovieDetailsInfoUseCase;
  final GetMovieActorsUseCase _getMovieActorsUseCase;
  final SearchMovieAccordingToCategoryUseCase
  _searchMovieAccordingToCategoryUseCase;

  MovieDetailManagement(
    this._getMovieDetailsInfoUseCase,
    this._getMovieActorsUseCase,
    this._searchMovieAccordingToCategoryUseCase,
  ) : super(MovieDetailState());

  void getMovieDetailsInfo(String slug) async {
    emit(
      state.copyWith(
        movieDetails: null,
        isLoadingMovieDetails: true,
        errorMovieDetails: null,
      ),
    );
    try {
      final result = await _getMovieDetailsInfoUseCase.execute(slug);
      emit(
        state.copyWith(
          movieDetails: result,
          isLoadingMovieDetails: false,
          errorMovieDetails: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          movieDetails: null,
          isLoadingMovieDetails: false,
          errorMovieDetails: e.toString(),
        ),
      );
    }
  }

  void getMovieActors(String slug) async {
    emit(state.copyWith(isLoadingMovieActors: true, errorMovieActors: null));
    try {
      final result = await _getMovieActorsUseCase.execute(slug);
      emit(
        state.copyWith(
          movieActors: result,
          isLoadingMovieActors: false,
          errorMovieActors: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMovieActors: e.toString(),
          isLoadingMovieActors: false,
        ),
      );
    }
  }

  void relatedMovie(
    String category,
    String slug,
    bool isNew,
    Map<String, dynamic> params,
  ) async {
    if (!isNew) {
      final maxPage = (state.totalItems / 24).ceil();
      if (state.isLoadingMovieRelated || state.currentPage >= maxPage) return;
    }
    int nextPage = isNew ? 1 : state.currentPage + 1;
    emit(
      state.copyWith(
        movieRelated: isNew ? const [] : state.movieRelated,
        isLoadingMovieRelated: true,
        errorMovieRelated: null,
      ),
    );
    try {
      params["page"] = nextPage;
      final result = await _searchMovieAccordingToCategoryUseCase.execute(
        category,
        params,
      );
      result.removeWhere((element) => element.movieSlug == slug);
      print("${[...state.movieRelated, ...result].length}");
      emit(
        state.copyWith(
          movieRelated: isNew ? result : [...state.movieRelated, ...result],
          isLoadingMovieRelated: false,
          errorMovieRelated: null,
          currentPage: nextPage,
          totalItems: result.isEmpty
              ? 0
              : result[0].totalItems > 100
              ? 100
              : result[0].totalItems,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMovieRelated: e.toString(),
          isLoadingMovieRelated: false,
        ),
      );
    }
  }
}
