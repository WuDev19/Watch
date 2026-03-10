import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/usecases/GetMovieDetailsInfoUseCase.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/MovieDetailState.dart';

@injectable
class MovieDetailManagement extends Cubit<MovieDetailState> {
  final GetMovieDetailsInfoUseCase _getMovieDetailsInfoUseCase;

  MovieDetailManagement(this._getMovieDetailsInfoUseCase)
    : super(MovieDetailState());

  void getMovieDetailsInfo(String slug) async {
    emit(state.copyWith(movieDetails: null, isLoading: true, error: null));
    try {
      final result = await _getMovieDetailsInfoUseCase.execute(slug);
      emit(state.copyWith(movieDetails: result, isLoading: false, error: null));
    } catch (e) {
      print("loi $e");
      emit(
        state.copyWith(
          movieDetails: null,
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

}
