import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';

class MovieDetailState extends Equatable {
  final MovieDetails? movieDetails;
  final bool isLoading;
  final String? error;

  MovieDetailState({this.movieDetails, this.isLoading = false, this.error});

  MovieDetailState copyWith({
    MovieDetails? movieDetails,
    bool? isLoading,
    String? error,
  }) {
    return MovieDetailState(
      movieDetails: movieDetails,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [movieDetails, isLoading, error];
}
