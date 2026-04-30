import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatched.dart';

class HomeState {
  final List<MovieDisplay> movies;
  final bool isLoading;
  final String? error;

  final MovieWatched? movieWatched;
  final bool isLoadingMovieWatched;
  final String? errorMovieWatched;

  const HomeState({
    this.movies = const [],
    this.isLoading = false,
    this.error,
    this.movieWatched,
    this.isLoadingMovieWatched = false,
    this.errorMovieWatched,
  });

  HomeState copyWith({
    List<MovieDisplay>? movies,
    bool? isLoading,
    String? error,
    MovieWatched? movieWatched,
    bool? isLoadingMovieWatched,
    String? errorMovieWatched,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      movieWatched: movieWatched ?? this.movieWatched,
      isLoadingMovieWatched:
          isLoadingMovieWatched ?? this.isLoadingMovieWatched,
      errorMovieWatched: errorMovieWatched,
    );
  }
}
