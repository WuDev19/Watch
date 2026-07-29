import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/DeleteListFavoriteMovieUseCase.dart';
import 'package:movie_app/features/profile/domain/usecases/DeleteAllFavoriteMovieUseCase.dart';
import 'package:movie_app/features/profile/presentation/favorite/state/FavoriteState.dart';

import '../../../../../utils/constants.dart';
import '../../../../movie/domain/usecases/GetMyFavoriteMovieUseCase.dart';
import '../../../domain/usecases/SearchFavoriteMovieUseCase.dart';

@injectable
class FavoriteManagement extends Cubit<FavoriteState> {
  final GetMyFavoriteMovieUseCase _getMyFavoriteMovieUseCase;
  final DeleteAllFavoriteMovieUseCase _deleteAllFavoriteMovieUseCase;
  final DeleteListFavoriteMovieUseCase _deleteFavoriteMovieUseCase;
  final SearchFavoriteMovieUseCase _searchFavoriteMovieUseCase;

  FavoriteManagement(
    this._getMyFavoriteMovieUseCase,
    this._deleteAllFavoriteMovieUseCase,
    this._deleteFavoriteMovieUseCase,
    this._searchFavoriteMovieUseCase,
  ) : super(const FavoriteState());

  void getMyFavoriteMovie(bool isRefresh) async {
    if (!isRefresh) {
      if (state.isLoadingFavorite || state.isLastFavorite) return;
    }
    final nextPage = isRefresh ? 0 : state.currentPageFavorite + 1;
    emit(
      state.copyWith(
        favorite: isRefresh ? const [] : state.favorite,
        isLoadingFavorite: true,
      ),
    );
    try {
      final result = await _getMyFavoriteMovieUseCase.execute(
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          favorite: isRefresh ? result : [...state.favorite, ...result],
          isLoadingFavorite: false,
          currentPageFavorite: nextPage,
          isLastFavorite: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(errorFavorite: e.toString(), isLoadingFavorite: false),
      );
    }
  }

  void searchFavoriteMovie(String keyword, bool isNewSearch) async {
    if (!isNewSearch) {
      if (state.isLoadingFavorite || state.isLastFavorite) return;
    }
    final nextPage = isNewSearch ? 0 : state.currentPageFavorite + 1;
    emit(
      state.copyWith(
        favorite: isNewSearch ? const [] : state.favorite,
        isLoadingFavorite: true,
      ),
    );
    try {
      final result = await _searchFavoriteMovieUseCase.execute(
        keyword,
        nextPage,
        Constants.defaultSize,
      );
      emit(
        state.copyWith(
          favorite: isNewSearch ? result : [...state.favorite, ...result],
          isLoadingFavorite: false,
          currentPageFavorite: nextPage,
          isLastFavorite: result.length < Constants.defaultSize,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(errorFavorite: e.toString(), isLoadingFavorite: false),
      );
    }
  }

  void deleteAllFavoriteMovie() async {
    try {
      await _deleteAllFavoriteMovieUseCase.execute();
      emit(
        state.copyWith(
          currentPageFavorite: -1,
          isLastFavorite: false,
          favorite: [],
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorFavorite: e.toString()));
    }
  }

  Future<void> deleteFavoriteMovie(List<String> slug) =>
      _deleteFavoriteMovieUseCase.execute(slug);
}
