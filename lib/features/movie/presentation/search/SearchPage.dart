import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/features/movie/presentation/search/state/SearchState.dart';
import 'package:movie_app/features/movie/presentation/search/state_management/SearchPageManagement.dart';
import 'package:movie_app/features/movie/presentation/search/widgets/CategoryWidget.dart';
import 'package:movie_app/features/movie/presentation/search/widgets/CountryWidget.dart';
import 'package:movie_app/features/movie/presentation/search/widgets/SearchResultItem.dart';
import 'package:movie_app/features/movie/presentation/search/widgets/YearWidget.dart';
import '../../../../core/colors/VColors.dart';
import '../../domain/models/SearchMovieDisplay.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textEditingController;
  late ScrollController _searchController;
  late ValueNotifier<int> _selectedCategory;
  late SearchPageManagement _searchPageManagement;
  bool _isSearchKeyWord = false;
  String _slugCategory = "";
  String _slugCountry = "";
  int _slugYear = 0;
  bool _isLoadingMore = false;
  Map<String, dynamic> dynamicCategory = {
    "sort_field": "year",
    "sort_type": "desc",
  };
  Map<String, dynamic> dynamicCountry = {
    "sort_field": "year",
    "sort_type": "desc",
  };
  Map<String, dynamic> dynamicYear = {
    "sort_field": "year",
    "sort_type": "desc",
  };
  bool _isCategoryFirst = false;
  bool _isCountryFirst = false;
  bool _isYearFirst = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _searchController = ScrollController();
    _selectedCategory = ValueNotifier(-1);
    _searchPageManagement = context.read<SearchPageManagement>();
    _searchController.addListener(_onScrollSearchLast);
    _searchPageManagement.getCategories();
    _searchPageManagement.getCountries();
    _searchPageManagement.getYears();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _searchController.removeListener(_onScrollSearchLast);
    _searchController.dispose();
    _selectedCategory.dispose();
    super.dispose();
  }

  void _onScrollSearchLast() {
    if (_searchController.offset >=
        _searchController.position.maxScrollExtent * 0.9) {
      if (_isLoadingMore) return;
      _isLoadingMore = true;
      _isSearchKeyWord
          ? _searchPageManagement.searchMovie(
              _textEditingController.text,
              false,
            )
          : _isCategoryFirst
          ? _searchPageManagement.searchMovieAccordingToCategory(
              _slugCategory,
              false,
              dynamicCategory,
            )
          : _isCountryFirst
          ? _searchPageManagement.searchMovieAccordingToCountry(
              _slugCountry,
              false,
              dynamicCountry,
            )
          : _searchPageManagement.searchMovieAccordingToYear(
              _slugYear,
              false,
              dynamicYear,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VColors.blackBackground,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            //sau bọc vào future builder để call lấy lịch sử search
            SearchBar(
              controller: _textEditingController,
              leading: InkWell(
                onTap: () {
                  if (_textEditingController.text.isNotEmpty) {
                    _isSearchKeyWord = true;
                    _searchPageManagement.searchMovie(
                      _textEditingController.text,
                      true,
                    );
                  }
                },
                child: const Icon(Icons.search, color: VColors.colorIcon),
              ),
              hintText: "Search movies...",
              elevation: const WidgetStatePropertyAll(10),
              hintStyle: const WidgetStatePropertyAll(
                TextStyle(color: Colors.white),
              ),
              backgroundColor: const WidgetStatePropertyAll(VColors.greySearch),
              textStyle: const WidgetStatePropertyAll(
                TextStyle(color: Colors.white),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _isSearchKeyWord = true;
                  _searchPageManagement.searchMovie(
                    _textEditingController.text,
                    true,
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            //danh sách category
            CategoryWidget(
              callback: (isSearchKeyword, slugCategory) {
                _isSearchKeyWord = isSearchKeyword;
                _slugCategory = slugCategory;
                if (!_isCountryFirst && !_isYearFirst) {
                  _isCategoryFirst = true;
                }
              },
              isClear: (isClear) {
                //ham nay de clear cai lan dau minh bam (vi du minh bam category truoc thi khi bam lai vao chinh no thi clear)
                if (isClear && _isCategoryFirst) {
                  _isCategoryFirst = false;
                }
              },
              onSearch: (bool isNewCategory, String categorySlug) {
                if (_isCategoryFirst) {
                  _searchPageManagement.searchMovieAccordingToCategory(
                    categorySlug,
                    isNewCategory,
                    dynamicCategory,
                  );
                } else if (_isCountryFirst) {
                  dynamicCountry["category"] = categorySlug;
                  _searchPageManagement.searchMovieAccordingToCountry(
                    _slugCountry,
                    isNewCategory,
                    dynamicCountry,
                  );
                } else if (_isYearFirst) {
                  dynamicYear["category"] = categorySlug;
                  _searchPageManagement.searchMovieAccordingToYear(
                    _slugYear,
                    isNewCategory,
                    dynamicYear,
                  );
                }
              },
            ),
            const SizedBox(height: 5),
            CountryWidget(
              callback: (isSearchKeyword, slugCategory) {
                _isSearchKeyWord = isSearchKeyword;
                _slugCountry = slugCategory;
                if (!_isCategoryFirst && !_isYearFirst) {
                  _isCountryFirst = true;
                }
              },
              isClear: (isClear) {
                if (isClear && _isCountryFirst) {
                  _isCountryFirst = false;
                }
              },
              onSearch: (isNewCountry, countrySlug) {
                if (_isCountryFirst) {
                  _searchPageManagement.searchMovieAccordingToCountry(
                    countrySlug,
                    isNewCountry,
                    dynamicCountry,
                  );
                } else if (_isCategoryFirst) {
                  dynamicCategory["country"] = countrySlug;
                  _searchPageManagement.searchMovieAccordingToCategory(
                    _slugCategory,
                    isNewCountry,
                    dynamicCategory,
                  );
                } else if (_isYearFirst) {
                  dynamicYear["country"] = countrySlug;
                  _searchPageManagement.searchMovieAccordingToYear(
                    _slugYear,
                    isNewCountry,
                    dynamicYear,
                  );
                }
              },
            ),
            const SizedBox(height: 5),
            YearWidget(
              callback: (isSearchKeyword, year) {
                _isSearchKeyWord = isSearchKeyword;
                _slugYear = year;
                if (!_isCategoryFirst && !_isCountryFirst) {
                  _isYearFirst = true;
                }
              },
              isClear: (isClear) {
                if (isClear && _isYearFirst) {
                  _isYearFirst = false;
                }
              },
              onSearch: (isNewYear, year) {
                if (_isYearFirst) {
                  _searchPageManagement.searchMovieAccordingToYear(
                    year,
                    isNewYear,
                    dynamicYear,
                  );
                } else if (_isCategoryFirst) {
                  dynamicCategory["year"] = year;
                  _searchPageManagement.searchMovieAccordingToCategory(
                    _slugCategory,
                    isNewYear,
                    dynamicCategory,
                  );
                } else if (_isCountryFirst) {
                  dynamicCountry["year"] = year;
                  _searchPageManagement.searchMovieAccordingToCountry(
                    _slugCountry,
                    isNewYear,
                    dynamicCountry,
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            //danh sách khi tìm kiếm
            Expanded(
              child:
                  BlocSelector<
                    SearchPageManagement,
                    SearchState,
                    (
                      List<SearchMovieDisplay> movies,
                      bool isMoviesLoading,
                      String? error,
                    )
                  >(
                    selector: (state) {
                      return (
                        state.movies,
                        state.isMoviesLoading,
                        state.errorMovies,
                      );
                    },
                    builder: (BuildContext context, state) {
                      _isLoadingMore = false;
                      if (state.$2 == true &&
                          state.$1.isEmpty &&
                          state.$3 == null) {
                        return Center(
                          child: LottieBuilder.asset(
                            "assets/lottie/loading.json",
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                        );
                      }
                      if (state.$3 != null && state.$2 == false) {
                        return Center(
                          child: InkWell(
                            onTap: () {
                              _isSearchKeyWord = true;
                              _searchPageManagement.searchMovie(
                                _textEditingController.text,
                                true,
                              );
                            },
                            child: Image.asset(
                              "assets/images/try.png",
                              width: 50,
                              height: 50,
                              color: VColors.colorIcon,
                            ),
                          ),
                        );
                      }
                      if (state.$1.isEmpty &&
                          state.$2 == false &&
                          state.$3 == null) {
                        return Center(
                          child: Text(
                            state.$1.isEmpty && _textEditingController.text.isNotEmpty
                                ? "None of the movies match your keywords"
                                : _textEditingController.text.isEmpty
                                ? "Search your favorite movies"
                                : "None of the movies match your keywords",
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return MasonryGridView.count(
                        key: PageStorageKey("search_movies_key"),
                        controller: _searchController,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          final result = state.$1[index];
                          return InkWell(
                            onTap: () => context.push(
                              "/movie-details/${result.movieSlug}",
                            ),
                            child: SearchResultItem(
                              moviePoster: result.moviePoster,
                              movieName: result.movieName,
                              movieYear: result.movieYear,
                            ),
                          );
                        },
                        itemCount: state.$1.length,
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
