import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';

class SettingState extends Equatable {
  final List<FavoriteMovieModel> favoriteMovies;
  final bool favoriteLoading;
  final String? favoriteError;

  const SettingState({
    this.favoriteMovies = const [],
    this.favoriteLoading = false,
    this.favoriteError,
  });

  SettingState copyWith({
    List<FavoriteMovieModel>? favoriteMovies,
    bool? favoriteLoading,
    String? favoriteError,
  }) {
    return SettingState(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      favoriteLoading: favoriteLoading ?? this.favoriteLoading,
      favoriteError: favoriteError,
    );
  }

  @override
  List<Object?> get props => [favoriteMovies, favoriteLoading, favoriteError];
}
