import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';

class SearchState extends Equatable {
  final List<SearchMovieDisplay> movies;
  final List<CategoryModel> categories;
  final bool isMoviesLoading;
  final bool isCategoriesLoading;
  final String? errorMovies;
  final String? errorCategories;
  final int currentPageMovies;
  final int currentPageMoviesCategory;
  final int totalItems;

  const SearchState({
    this.movies = const [],
    this.categories = const [],
    this.isMoviesLoading = false,
    this.isCategoriesLoading = false,
    this.errorMovies,
    this.errorCategories,
    this.currentPageMovies = 0,
    this.currentPageMoviesCategory = 0,
    this.totalItems = 24,
  });

  SearchState copyWith({
    List<SearchMovieDisplay>? movies,
    List<CategoryModel>? categories,
    bool? isMoviesLoading,
    bool? isCategoriesLoading,
    String? errorMovies,
    String? errorCategories,
    int? currentPageMovies,
    int? currentPageMoviesCategory,
    int? totalItems,
  }) {
    return SearchState(
      movies: movies ?? this.movies,
      categories: categories ?? this.categories,
      isMoviesLoading: isMoviesLoading ?? this.isMoviesLoading,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      errorMovies: errorMovies,
      errorCategories: errorCategories,
      currentPageMovies: currentPageMovies ?? this.currentPageMovies,
      currentPageMoviesCategory:
          currentPageMoviesCategory ?? this.currentPageMoviesCategory,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  @override
  List<Object?> get props => [
    movies,
    categories,
    isMoviesLoading,
    isCategoriesLoading,
    errorMovies,
    errorCategories,
    currentPageMovies,
    currentPageMoviesCategory,
    totalItems,
  ]; //instance chỉ khác nhau khi các field trong này khác nhau
}
