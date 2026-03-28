import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';

class SearchState extends Equatable {
  final List<SearchMovieDisplay> movies;
  final List<CategoryModel> categories;
  final List<CountryModel> countries;
  final List<YearModel> years;
  final bool isMoviesLoading;
  final bool isCategoriesLoading;
  final bool isCountriesLoading;
  final bool isYearsLoading;
  final String? errorMovies;
  final String? errorCategories;
  final String? errorCountries;
  final String? errorYears;
  final int currentPageMovies;
  final int currentPageMoviesCategory;
  final int currentPageMoviesCountry;
  final int currentPageMoviesYear;
  final int totalItems;
  final int totalItemsCategory;
  final int totalItemsCountry;
  final int totalItemsYear;

  const SearchState({
    this.movies = const [],
    this.categories = const [],
    this.countries = const [],
    this.years = const [],
    this.isMoviesLoading = false,
    this.isCategoriesLoading = false,
    this.isCountriesLoading = false,
    this.isYearsLoading = false,
    this.errorMovies,
    this.errorCategories,
    this.errorCountries,
    this.errorYears,
    this.currentPageMovies = 0,
    this.currentPageMoviesCategory = 0,
    this.currentPageMoviesCountry = 0,
    this.currentPageMoviesYear = 0,
    this.totalItems = 24,
    this.totalItemsCategory = 24,
    this.totalItemsCountry = 24,
    this.totalItemsYear = 24,
  });

  SearchState copyWith({
    List<SearchMovieDisplay>? movies,
    List<CategoryModel>? categories,
    List<CountryModel>? countries,
    List<YearModel>? years,
    bool? isMoviesLoading,
    bool? isCategoriesLoading,
    bool? isCountriesLoading,
    bool? isYearsLoading,
    String? errorMovies,
    String? errorCategories,
    String? errorCountries,
    String? errorYears,
    int? currentPageMovies,
    int? currentPageMoviesCategory,
    int? currentPageMoviesCountry,
    int? currentPageMoviesYear,
    int? totalItems,
    int? totalItemsCategory,
    int? totalItemsCountry,
    int? totalItemsYear,
  }) {
    return SearchState(
      movies: movies ?? this.movies,
      categories: categories ?? this.categories,
      countries: countries ?? this.countries,
      years: years ?? this.years,
      isMoviesLoading: isMoviesLoading ?? this.isMoviesLoading,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isCountriesLoading: isCountriesLoading ?? this.isCountriesLoading,
      isYearsLoading: isYearsLoading ?? this.isYearsLoading,
      errorMovies: errorMovies,
      errorCategories: errorCategories,
      errorCountries: errorCountries,
      errorYears: errorYears,
      currentPageMovies: currentPageMovies ?? this.currentPageMovies,
      currentPageMoviesCategory:
          currentPageMoviesCategory ?? this.currentPageMoviesCategory,
      currentPageMoviesCountry:
          currentPageMoviesCountry ?? this.currentPageMoviesCountry,
      currentPageMoviesYear:
          currentPageMoviesYear ?? this.currentPageMoviesYear,
      totalItems: totalItems ?? this.totalItems,
      totalItemsCategory: totalItemsCategory ?? this.totalItemsCategory,
      totalItemsCountry: totalItemsCountry ?? this.totalItemsCountry,
      totalItemsYear: totalItemsYear ?? this.totalItemsYear,
    );
  }

  @override
  String toString() {
    return 'SearchState{totalItems: $totalItems, totalItemsCategory: $totalItemsCategory, totalItemsCountry: $totalItemsCountry, totalItemsYear: $totalItemsYear}';
  }

  @override
  List<Object?> get props => [
    movies,
    categories,
    countries,
    years,
    isMoviesLoading,
    isCategoriesLoading,
    isCountriesLoading,
    isYearsLoading,
    errorMovies,
    errorCategories,
    errorCountries,
    errorYears,
    currentPageMovies,
    currentPageMoviesCategory,
    currentPageMoviesCountry,
    currentPageMoviesYear,
    totalItems,
    totalItemsCategory,
    totalItemsCountry,
    totalItemsYear,
  ]; //instance chỉ khác nhau khi các field trong này khác nhau
}
