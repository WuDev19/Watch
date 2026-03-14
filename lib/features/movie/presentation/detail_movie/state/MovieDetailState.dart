import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';

class MovieDetailState extends Equatable {
  final MovieDetails? movieDetails;
  final bool isLoadingMovieDetails;
  final String? errorMovieDetails;
  final List<MovieActors> movieActors;
  final bool isLoadingMovieActors;
  final String? errorMovieActors;
  final List<SearchMovieDisplay> movieRelated;
  final bool isLoadingMovieRelated;
  final String? errorMovieRelated;
  final int totalItems;
  final int currentPage;

  const MovieDetailState({
    this.movieDetails,
    this.isLoadingMovieDetails = false,
    this.errorMovieDetails,
    this.movieActors = const [],
    this.isLoadingMovieActors = false,
    this.errorMovieActors,
    this.movieRelated = const [],
    this.isLoadingMovieRelated = false,
    this.errorMovieRelated,
    this.totalItems = 24,
    this.currentPage = 0
  });

  MovieDetailState copyWith({
    MovieDetails? movieDetails,
    bool? isLoadingMovieDetails,
    String? errorMovieDetails,
    List<MovieActors>? movieActors,
    bool? isLoadingMovieActors,
    String? errorMovieActors,
    List<SearchMovieDisplay>? movieRelated,
    bool? isLoadingMovieRelated,
    String? errorMovieRelated,
    int? totalItems,
    int? currentPage
  }) {
    return MovieDetailState(
      movieDetails: movieDetails ?? this.movieDetails,
      //nếu vừa call có data xong bên actor copywith ko truyền vào thì bị set lại = null, selector thấy thay đổi thì rebuild, test thử xem
      isLoadingMovieDetails:
          isLoadingMovieDetails ?? this.isLoadingMovieDetails,
      errorMovieDetails: errorMovieDetails,
      movieActors: movieActors ?? this.movieActors,
      isLoadingMovieActors: isLoadingMovieActors ?? this.isLoadingMovieActors,
      errorMovieActors: errorMovieActors,
      movieRelated: movieRelated ?? this.movieRelated,
      isLoadingMovieRelated:
          isLoadingMovieRelated ?? this.isLoadingMovieRelated,
      errorMovieRelated: errorMovieRelated,
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage
    );
  }

  @override
  List<Object?> get props => [
    movieDetails,
    isLoadingMovieDetails,
    errorMovieDetails,
    movieActors,
    isLoadingMovieActors,
    errorMovieActors,
    movieRelated,
    isLoadingMovieRelated,
    errorMovieRelated,
    totalItems,
    currentPage
  ];
}
