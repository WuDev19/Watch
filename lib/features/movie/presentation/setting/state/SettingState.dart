import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';

class SettingState extends Equatable {
  final List<FavoriteMovieModel> favoriteMovies;
  final bool favoriteLoading;
  final String? favoriteError;
  final List<MovieWatching> watchingMovies;
  final bool watchingLoading;
  final String? watchingError;

  const SettingState({
    this.favoriteMovies = const [],
    this.favoriteLoading = false,
    this.favoriteError,
    this.watchingMovies = const [],
    this.watchingLoading = false,
    this.watchingError,
  });

  SettingState copyWith({
    List<FavoriteMovieModel>? favoriteMovies,
    bool? favoriteLoading,
    String? favoriteError,
    List<MovieWatching>? watchingMovies,
    bool? watchingLoading,
    String? watchingError,
  }) {
    return SettingState(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      favoriteLoading: favoriteLoading ?? this.favoriteLoading,
      favoriteError: favoriteError,
      watchingMovies: watchingMovies ?? this.watchingMovies,
      watchingLoading: watchingLoading ?? this.watchingLoading,
      watchingError: watchingError,
    );
  }

  @override
  List<Object?> get props => [
    favoriteMovies,
    favoriteLoading,
    favoriteError,
    watchingMovies,
    watchingLoading,
    watchingError,
  ];
}
