import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/Comment.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/domain/usecases/PostCommentUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/SaveMovieHistoryUseCase.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state/WatchMovieState.dart';
import 'package:movie_app/features/profile/domain/usecases/GetMyProfileUseCase.dart';

import '../../../domain/models/DownloadStart.dart';
import '../../../domain/models/FavoriteMovieModel.dart';
import '../../../domain/usecases/CheckFavoriteMovieUseCase.dart';
import '../../../domain/usecases/DeleteCommentUseCase.dart';
import '../../../domain/usecases/DeleteFavoriteUseCase.dart';
import '../../../domain/usecases/DownloadMovieUseCase.dart';
import '../../../domain/usecases/GetCommentOfMovieUseCase.dart';
import '../../../domain/usecases/SaveFavoriteMovieUseCase.dart';

@injectable
class WatchMovieManagement extends Cubit<WatchMovieState> {
  final SaveMovieHistoryUseCase _saveMovieHistoryUseCase;
  final CheckFavoriteMovieUseCase _checkFavoriteMovieUseCase;
  final SaveFavoriteMovieUseCase _saveFavoriteMovieUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;
  final DownloadMovieUseCase _downloadMovieUseCase;
  final GetMyProfileUseCase _getMyProfileUseCase;
  final PostCommentUseCase _postCommentUseCase;
  final DeleteCommentUseCase _deleteCommentUseCase;
  final GetCommentOfMovieUseCase _getCommentOfMovieUseCase;

  WatchMovieManagement(
    this._saveMovieHistoryUseCase,
    this._checkFavoriteMovieUseCase,
    this._saveFavoriteMovieUseCase,
    this._deleteFavoriteUseCase,
    this._downloadMovieUseCase,
    this._getMyProfileUseCase,
    this._postCommentUseCase,
    this._deleteCommentUseCase,
    this._getCommentOfMovieUseCase,
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

  void getMyProfile() async {
    try {
      final profile = await _getMyProfileUseCase.execute();
      emit(
        state.copyWith(
          selfState: state.selfState.copyWith(
            avt: profile.avt,
            name: profile.name,
          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void postComment(
    String? avt,
    String name,
    String comment,
    String movieSlug,
  ) async {
    emit(
      state.copyWith(
        actionCommentState: state.actionCommentState.copyWith(isLoading: true),
      ),
    );
    try {
      await _postCommentUseCase.execute(
        Comment(avt: avt, name: name, comment: comment, movieSlug: movieSlug),
      );
      emit(
        state.copyWith(
          actionCommentState: state.actionCommentState.copyWith(
            isLoading: false,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionCommentState: state.actionCommentState.copyWith(
            isLoading: false,
            error: e.toString(),
          ),
        ),
      );
    }
  }

  void deleteComment(String id) async {
    emit(
      state.copyWith(
        actionCommentState: state.actionCommentState.copyWith(isLoading: true),
      ),
    );
    try {
      await _deleteCommentUseCase.execute(id);
      emit(
        state.copyWith(
          actionCommentState: state.actionCommentState.copyWith(
            isLoading: false,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionCommentState: state.actionCommentState.copyWith(
            isLoading: false,
            error: e.toString(),
          ),
        ),
      );
    }
  }

  void getComments(String movieSlug) async {
    emit(
      state.copyWith(
        getCommentState: state.getCommentState.copyWith(isLoading: true),
      ),
    );
    try {
      final response = await _getCommentOfMovieUseCase.execute(movieSlug);
      emit(
        state.copyWith(
          getCommentState: state.getCommentState.copyWith(
            commentTotal: response,
            isLoading: false,
          ),
        ),
          );
    } catch (e) {
      emit(
        state.copyWith(
          getCommentState: state.getCommentState.copyWith(
            isLoading: false,
            error: e.toString(),
          ),
        ),
      );
    }
  }
}
