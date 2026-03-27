import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/domain/usecases/GetAllYearUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetCategoriesUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/GetCountryUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/SearchMovieAccordingToCategoryUseCase.dart';
import 'package:movie_app/features/movie/domain/usecases/SearchMovieUseCase.dart';
import 'package:movie_app/features/movie/presentation/search/state/SearchState.dart';

@injectable
class SearchPageManagement extends Cubit<SearchState> {
  final SearchMovieUseCase _searchMovieUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final SearchMovieAccordingToCategoryUseCase
  _searchMovieAccordingToCategoryUseCase;
  final GetCountryUseCase _getCountryUseCase;
  final GetAllYearUseCase _getAllYearUseCase;
  final List<SearchMovieDisplay> allMovies = [];

  SearchPageManagement(
    this._searchMovieUseCase,
    this._getCategoriesUseCase,
    this._searchMovieAccordingToCategoryUseCase,
    this._getCountryUseCase,
    this._getAllYearUseCase,
  ) : super(SearchState());

  void searchMovie(String keyword, bool isNewSearch) async {
    final maxPage = (state.totalItems / 24).ceil();
    if (state.isMoviesLoading || state.currentPageMovies >= maxPage) return;
    int nextPage = isNewSearch == true ? 1 : state.currentPageMovies + 1;
    emit(
      state.copyWith(
        isMoviesLoading: true,
        errorMovies: null,
        movies: isNewSearch == true ? [] : state.movies,
      ),
    );
    try {
      final data = await _searchMovieUseCase.execute(keyword, nextPage);
      emit(
        state.copyWith(
          movies: isNewSearch == true ? data : [...state.movies, ...data],
          isMoviesLoading: false,
          errorMovies: null,
          currentPageMovies: nextPage,
          totalItems: data.isNotEmpty ? data[0].totalItems : state.totalItems,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(errorMovies: e.toString(), isMoviesLoading: false));
    }
  }

  void getCategories() async {
    emit(
      state.copyWith(
        isCategoriesLoading: true,
        errorCategories: null,
        categories: [],
      ),
    );
    try {
      final data = await _getCategoriesUseCase.execute();
      emit(
        state.copyWith(
          categories: data,
          isCategoriesLoading: false,
          errorCategories: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCategories: e.toString(),
          isCategoriesLoading: false,
          categories: [],
        ),
      );
    }
  }

  void searchMovieAccordingToCategory(
    String category,
    bool isNewCategory,
  ) async {
    final maxPage = (state.totalItems / 24).ceil();
    if (state.isMoviesLoading || state.currentPageMoviesCategory >= maxPage) {
      return;
    }
    emit(
      state.copyWith(
        movies: isNewCategory ? [] : state.movies,
        isMoviesLoading: true,
        errorMovies: null,
      ),
    );
    int nextPage = isNewCategory == true
        ? 1
        : state.currentPageMoviesCategory + 1;
    try {
      final data = await _searchMovieAccordingToCategoryUseCase.execute(
        category,
        nextPage,
      );
      emit(
        state.copyWith(
          movies: isNewCategory ? data : [...state.movies, ...data],
          isMoviesLoading: false,
          errorMovies: null,
          currentPageMoviesCategory: nextPage,
          totalItems: data.isNotEmpty ? data[0].totalItems : state.totalItems,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isMoviesLoading: false, errorMovies: e.toString()));
    }
  }

  void searchMovieAccordingToCountry(
    String countrySlug,
    bool isNewCountry,
  ) async {}

  void getCountries() async {
    emit(
      state.copyWith(
        isCountriesLoading: true,
        errorCountries: null,
        countries: [],
      ),
    );
    try {
      final data = await _getCountryUseCase.execute();
      emit(
        state.copyWith(
          countries: data,
          isCountriesLoading: false,
          errorCountries: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCountries: e.toString(),
          isCountriesLoading: false,
          countries: [],
        ),
      );
    }
  }

  void getYears() async {
    emit(
      state.copyWith(
        isYearsLoading: true,
        errorYears: null,
        years: [],
      ),
    );
    try {
      final data = await _getAllYearUseCase.execute();
      emit(
        state.copyWith(
          years: data,
          isYearsLoading: false,
          errorYears: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorYears: e.toString(),
          isYearsLoading: false,
          years: [],
        ),
      );
    }
  }
}
