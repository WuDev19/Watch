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
  bool _isLoadingMore = false;

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
          : _searchPageManagement.searchMovieAccordingToCategory(
              _slugCategory,
              false,
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
              },
            ),
            const SizedBox(height: 5),
            CountryWidget(callback: (isSearchKeyword, slugCategory) {}),
            const SizedBox(height: 5),
            YearWidget(callback: (isSearchKeyword, year) {}),
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
                            _textEditingController.text.isEmpty
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
