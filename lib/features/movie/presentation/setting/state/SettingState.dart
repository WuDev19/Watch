import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';

class SettingState extends Equatable {
  final List<FavoriteMovieModel> favoriteMovies;
  final bool favoriteLoading;
  final String? favoriteError;
  final int currentPageFavorite;
  final bool isFavoriteLast;

  final List<MovieWatching> watchingMovies;
  final bool watchingLoading;
  final String? watchingError;
  final int currentPageWatching;
  final bool isWatchingLast;

  final List<MovieWatching> watchedMovies;
  final bool watchedLoading;
  final String? watchedError;
  final int currentPageWatched;
  final bool isWatchedLast;

  const SettingState({
    this.favoriteMovies = const [],
    this.favoriteLoading = false,
    this.favoriteError,
    this.currentPageFavorite = -1,
    this.isFavoriteLast = false,

    this.watchingMovies = const [],
    this.watchingLoading = false,
    this.watchingError,
    this.currentPageWatching = -1,
    this.isWatchingLast = false,

    this.watchedMovies = const [],
    this.watchedLoading = false,
    this.watchedError,
    this.currentPageWatched = -1,
    this.isWatchedLast = false,
  });

  SettingState copyWith({
    List<FavoriteMovieModel>? favoriteMovies,
    bool? favoriteLoading,
    String? favoriteError,
    int? currentPageFavorite,
    bool? isFavoriteLast,
    List<MovieWatching>? watchingMovies,
    bool? watchingLoading,
    String? watchingError,
    int? currentPageWatching,
    bool? isWatchingLast,
    List<MovieWatching>? watchedMovies,
    bool? watchedLoading,
    String? watchedError,
    int? currentPageWatched,
    bool? isWatchedLast,
  }) {
    return SettingState(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      favoriteLoading: favoriteLoading ?? this.favoriteLoading,
      favoriteError: favoriteError,
      currentPageFavorite: currentPageFavorite ?? this.currentPageFavorite,
      isFavoriteLast: isFavoriteLast ?? this.isFavoriteLast,
      watchingMovies: watchingMovies ?? this.watchingMovies,
      watchingLoading: watchingLoading ?? this.watchingLoading,
      watchingError: watchingError,
      currentPageWatching: currentPageWatching ?? this.currentPageWatching,
      isWatchingLast: isWatchingLast ?? this.isWatchingLast,
      watchedMovies: watchedMovies ?? this.watchedMovies,
      watchedLoading: watchedLoading ?? this.watchedLoading,
      watchedError: watchedError,
      currentPageWatched: currentPageWatched ?? this.currentPageWatched,
      isWatchedLast: isWatchedLast ?? this.isWatchedLast,
    );
  }

  @override
  List<Object?> get props => [
    favoriteMovies,
    favoriteLoading,
    favoriteError,
    currentPageFavorite,
    isFavoriteLast,
    watchingMovies,
    watchingLoading,
    watchingError,
    currentPageWatching,
    isWatchingLast,
    watchedMovies,
    watchedLoading,
    watchedError,
    currentPageWatched,
    isWatchedLast,
  ];
}
