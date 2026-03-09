import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';

class HomeState {
  final List<MovieDisplay> movies;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.movies = const [],
    this.isLoading = true,
    this.error,
  });

  HomeState copyWith({
    List<MovieDisplay>? movies,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

}
