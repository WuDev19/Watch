import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMyFavoriteMovieUseCase.dart';
import 'package:movie_app/features/movie/presentation/setting/state/SettingState.dart';

@injectable
class SettingScreenManagement extends Cubit<SettingState> {
  final GetMyFavoriteMovieUseCase _getMyFavoriteMovieUseCase;

  SettingScreenManagement(this._getMyFavoriteMovieUseCase)
    : super(SettingState());

  void getMyFavoriteMovie() async {
    emit(state.copyWith(favoriteLoading: true));
    try {
      final result = await _getMyFavoriteMovieUseCase.execute();
      emit(state.copyWith(favoriteMovies: result, favoriteLoading: false));
    } catch (e) {
      emit(state.copyWith(favoriteError: e.toString(), favoriteLoading: false));
    }
  }
}
