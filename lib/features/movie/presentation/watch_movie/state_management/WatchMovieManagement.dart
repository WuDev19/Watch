import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/domain/usecases/SaveMovieHistoryUseCase.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state/WatchMovieState.dart';

import '../../../domain/models/DownloadStart.dart';
import '../../../domain/models/FavoriteMovieModel.dart';
import '../../../domain/usecases/CheckFavoriteMovieUseCase.dart';
import '../../../domain/usecases/DeleteFavoriteUseCase.dart';
import '../../../domain/usecases/DownloadMovieUseCase.dart';
import '../../../domain/usecases/SaveFavoriteMovieUseCase.dart';

@injectable
class WatchMovieManagement extends Cubit<WatchMovieState> {
  final SaveMovieHistoryUseCase _saveMovieHistoryUseCase;
  final CheckFavoriteMovieUseCase _checkFavoriteMovieUseCase;
  final SaveFavoriteMovieUseCase _saveFavoriteMovieUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;
  final DownloadMovieUseCase _downloadMovieUseCase;

  WatchMovieManagement(
    this._saveMovieHistoryUseCase,
    this._checkFavoriteMovieUseCase,
    this._saveFavoriteMovieUseCase,
    this._deleteFavoriteUseCase,
    this._downloadMovieUseCase,
  ) : super(WatchMovieState());

  void saveMovieHistory(MovieHistoryModel model) async {
    await _saveMovieHistoryUseCase.execute(model);
  }

  void saveFavoriteMovie(FavoriteMovieModel model) async {
    await _saveFavoriteMovieUseCase.execute(model);
  }

  void deleteFavoriteMovie(String slug) async {
    await _deleteFavoriteUseCase.execute(slug);
  }

  Future<bool> checkFavoriteMovie(String slug) =>
      _checkFavoriteMovieUseCase.execute(slug);

  Future<void> download({
    required String url,
    required String name,
    required String episodeName,
    required String movieSlug,
  }) {
    return _downloadMovieUseCase.execute(
      DownloadStart(
        videoUrl: url,
        movieSlug: movieSlug,
        movieName: name,
        episodeName: episodeName,
      ),
    );
  }
}
