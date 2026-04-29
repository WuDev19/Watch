import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/domain/usecases/SaveMovieHistoryUseCase.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state/WatchMovieState.dart';

@injectable
class WatchMovieManagement extends Cubit<WatchMovieState> {
  final SaveMovieHistoryUseCase _saveMovieHistoryUseCase;

  WatchMovieManagement(this._saveMovieHistoryUseCase)
    : super(WatchMovieState());

  void saveMovieHistory(MovieHistoryModel model) async {
    await _saveMovieHistoryUseCase.execute(model);
  }
}
