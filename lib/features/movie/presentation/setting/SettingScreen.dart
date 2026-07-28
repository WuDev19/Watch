import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/EmptyDataWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/ErrorHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/LoadingHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/setting/state/SettingState.dart';
import 'package:movie_app/features/movie/presentation/setting/state_managment/SettingScreenManagement.dart';
import 'package:movie_app/features/movie/presentation/setting/widgets/FavoriteMovieWidget.dart';
import 'package:movie_app/features/movie/presentation/setting/widgets/LogInOutButton.dart';
import 'package:movie_app/features/movie/presentation/setting/widgets/WatchedMovieWidget.dart';
import 'package:movie_app/features/movie/presentation/setting/widgets/WatchingMovieWidget.dart';
import 'package:movie_app/utils/constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final double _secondaryTitle;
  late final double _screenWidth;
  late final double _imageHeight;
  late final double _imageWidth;
  late final SettingScreenManagement _settingScreenManagement;
  late final ValueNotifier<Set<int>> _selectedFavorite;
  late final ValueNotifier<bool> _isSelectedFavToDelete;
  late final ValueNotifier<Set<int>> _selectedWatching;
  late final ValueNotifier<bool> _isSelectedWatchingToDelete;
  late final ValueNotifier<Set<int>> _selectedWatched;
  late final ValueNotifier<bool> _isSelectedWatchedToDelete;
  late final ValueNotifier<bool> _isLogout;
  final ScrollController _favoriteController = ScrollController();
  final ScrollController _watchedController = ScrollController();
  final ScrollController _watchingController = ScrollController();
  bool _isFavoriteLoading = false;
  bool _isWatchedLoading = false;
  bool _isWatchingLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedFavorite = ValueNotifier({});
    _isSelectedFavToDelete = ValueNotifier(false);
    _selectedWatching = ValueNotifier({});
    _isSelectedWatchingToDelete = ValueNotifier(false);
    _selectedWatched = ValueNotifier({});
    _isSelectedWatchedToDelete = ValueNotifier(false);
    _isLogout = ValueNotifier(true);
    _settingScreenManagement = context.read<SettingScreenManagement>();
    _settingScreenManagement.getMyFavoriteMovie(false);
    _settingScreenManagement.getWatchingMovie(false);
    _settingScreenManagement.getWatchedMovie(false);
    _settingScreenManagement.checkLogin().then(
      (value) => _isLogout.value = value,
    );
    _favoriteController.addListener(_onLoadFavoriteMore);
    _watchedController.addListener(_onLoadWatchedMore);
    _watchingController.addListener(_onLoadWatchingMore);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _secondaryTitle = Constants.calculateFontSize(context, 1.1);
    _screenWidth = Constants.getWidthScreen(context);
    _imageHeight = Constants.getImageHeight(context);
    _imageWidth = Constants.getImageWidth(context);
  }

  @override
  void dispose() {
    _selectedFavorite.dispose();
    _isSelectedFavToDelete.dispose();
    _selectedWatching.dispose();
    _isSelectedWatchingToDelete.dispose();
    _selectedWatched.dispose();
    _isSelectedWatchedToDelete.dispose();
    _isLogout.dispose();
    _favoriteController.dispose();
    _watchedController.dispose();
    _watchingController.dispose();
    _favoriteController.removeListener(_onLoadFavoriteMore);
    _watchedController.removeListener(_onLoadWatchedMore);
    _watchingController.removeListener(_onLoadWatchingMore);
    super.dispose();
  }

  void _onLoadFavoriteMore() {
    if (_isFavoriteLoading) return;
    if (_favoriteController.offset >=
        _favoriteController.position.maxScrollExtent * 0.9) {
      _isFavoriteLoading = true;
      _settingScreenManagement.getMyFavoriteMovie(false);
    }
  }

  void _onLoadWatchedMore() {
    if (_isWatchedLoading) return;
    if (_watchedController.offset >=
        _watchedController.position.maxScrollExtent * 0.9) {
      _isWatchedLoading = true;
      _settingScreenManagement.getWatchedMovie(false);
    }
  }

  void _onLoadWatchingMore() {
    if (_isWatchingLoading) return;
    if (_watchingController.offset >=
        _watchingController.position.maxScrollExtent * 0.9) {
      _isWatchingLoading = true;
      _settingScreenManagement.getWatchingMovie(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final preDeleteFav = <String>{};
    final preDeleteWatching = <String>{};
    final preDeleteWatched = <String>{};
    return AnimatedBuilder(
      animation: Listenable.merge([
        _isSelectedFavToDelete,
        _isSelectedWatchingToDelete,
        _isSelectedWatchedToDelete,
      ]),
      builder: (BuildContext context, Widget? child) {
        final isSelecting =
            _isSelectedFavToDelete.value ||
            _isSelectedWatchingToDelete.value ||
            _isSelectedWatchedToDelete.value;
        return PopScope(
          canPop: !isSelecting,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (_isSelectedFavToDelete.value ||
                _isSelectedWatchingToDelete.value ||
                _isSelectedWatchedToDelete.value) {
              if (_isSelectedWatchedToDelete.value) {
                _isSelectedWatchedToDelete.value = false;
                _selectedWatched.value = {};
              }
              if (_isSelectedWatchingToDelete.value) {
                _isSelectedWatchingToDelete.value = false;
                _selectedWatching.value = {};
              }
              if (_isSelectedFavToDelete.value) {
                _isSelectedFavToDelete.value = false;
                _selectedFavorite.value = {};
              }
            }
          },
          child: Container(
            color: VColors.blackBackground,
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () async {
                _settingScreenManagement.getMyFavoriteMovie(true);
                _settingScreenManagement.getWatchingMovie(true);
                _settingScreenManagement.getWatchedMovie(true);
              },
              color: VColors.white,
              backgroundColor: VColors.colorIcon,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _isLogout,
                      builder: (context, isLogout, child) {
                        return !isLogout
                            ? SizedBox()
                            : InkWell(
                                onTap: () async {
                                  final result =
                                      await context.push("/profile") as String?;
                                  if (result != null && result == "logout") {
                                    _isLogout.value = false;
                                  }
                                },
                                child: Container(
                                  alignment: AlignmentGeometry.topRight,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: _screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Constants.favoriteMovie,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: _secondaryTitle,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _isSelectedFavToDelete,
                            builder: (context, value, child) {
                              return value == true
                                  ? InkWell(
                                      onTap: () async {
                                        _selectedFavorite.value = {};
                                        _isSelectedFavToDelete.value = false;
                                        await _settingScreenManagement
                                            .deleteFavoriteMovie(
                                              preDeleteFav.toList(),
                                            );
                                        _settingScreenManagement
                                            .getMyFavoriteMovie(true);
                                        preDeleteFav.clear();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  : SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: _imageHeight,
                      child:
                          BlocSelector<
                            SettingScreenManagement,
                            SettingState,
                            (List<FavoriteMovieModel>, bool, String?)
                          >(
                            selector: (state) => (
                              state.favoriteMovies,
                              state.favoriteLoading,
                              state.favoriteError,
                            ),
                            builder: (context, state) {
                              _isFavoriteLoading = false;
                              if (state.$3 != null) {
                                return ErrorHandleWidget(
                                  onTap: () => _settingScreenManagement
                                      .getMyFavoriteMovie(true),
                                );
                              }
                              if (state.$2 && state.$1.isEmpty) {
                                return const LoadingHandleWidget();
                              }
                              if (state.$1.isEmpty) {
                                return const EmptyDataWidget();
                              }
                              final favoriteMovies = state.$1;
                              return ListView.builder(
                                key: PageStorageKey("favorite_movie"),
                                controller: _favoriteController,
                                itemExtent: _imageWidth,
                                itemBuilder: (context, index) {
                                  final favorMovie = favoriteMovies[index];
                                  return ValueListenableBuilder(
                                    valueListenable: _isSelectedFavToDelete,
                                    builder: (context, isDelete, child) {
                                      return InkWell(
                                        onLongPress: () {
                                          _selectedFavorite.value = {index};
                                          _isSelectedFavToDelete.value = true;
                                          preDeleteFav.add(
                                            favorMovie.movieSlug,
                                          );
                                        },
                                        child: ValueListenableBuilder(
                                          valueListenable: _selectedFavorite,
                                          builder: (context, selectedPositions, child) {
                                            final isThisSelected =
                                                selectedPositions.contains(
                                                  index,
                                                );
                                            return isDelete
                                                ? AnimatedScale(
                                                    scale: isThisSelected
                                                        ? 0.9
                                                        : 1.0,
                                                    duration: const Duration(
                                                      milliseconds: 100,
                                                    ),
                                                    child: FavoriteMovieWidget(
                                                      isSelected:
                                                          isThisSelected,
                                                      favoriteMovie: favorMovie,
                                                      onChoose: (movieSlug) {
                                                        if (isThisSelected) {
                                                          selectedPositions
                                                              .remove(index);
                                                          preDeleteFav.remove(
                                                            movieSlug,
                                                          );
                                                        } else {
                                                          selectedPositions.add(
                                                            index,
                                                          );
                                                          preDeleteFav.add(
                                                            movieSlug,
                                                          );
                                                        }
                                                        _selectedFavorite
                                                            .value = Set.of(
                                                          selectedPositions,
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : FavoriteMovieWidget(
                                                    isSelected: false,
                                                    favoriteMovie: favorMovie,
                                                    onChoose: (movieSlug) {
                                                      context.push(
                                                        "/movie-details/$movieSlug",
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                itemCount: favoriteMovies.length,
                                scrollDirection: Axis.horizontal,
                              );
                            },
                          ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: _screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Constants.watchingMovie,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: _secondaryTitle,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _isSelectedWatchingToDelete,
                            builder: (context, value, child) {
                              return value == true
                                  ? InkWell(
                                      onTap: () async {
                                        _selectedWatching.value = {};
                                        _isSelectedWatchingToDelete.value =
                                            false;
                                        await _settingScreenManagement
                                            .deleteHistoryMovie(
                                              preDeleteWatching.toList(),
                                            );
                                        _settingScreenManagement
                                            .getWatchingMovie(true);
                                        preDeleteWatching.clear();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  : SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: _imageHeight,
                      child:
                          BlocSelector<
                            SettingScreenManagement,
                            SettingState,
                            (List<MovieWatching>, bool, String?)
                          >(
                            selector: (state) => (
                              state.watchingMovies,
                              state.watchingLoading,
                              state.watchingError,
                            ),
                            builder: (context, state) {
                              _isWatchingLoading = false;
                              if (state.$3 != null) {
                                return ErrorHandleWidget(
                                  onTap: () => _settingScreenManagement
                                      .getWatchingMovie(true),
                                );
                              }
                              if (state.$2 && state.$1.isEmpty) {
                                return const LoadingHandleWidget();
                              }
                              if (state.$1.isEmpty) {
                                return const EmptyDataWidget();
                              }
                              final watchingMovies = state.$1;
                              return ListView.builder(
                                key: PageStorageKey("watching_movie"),
                                controller: _watchingController,
                                itemExtent: _imageWidth,
                                itemBuilder: (context, index) {
                                  final movieWatching = watchingMovies[index];
                                  return ValueListenableBuilder(
                                    valueListenable:
                                        _isSelectedWatchingToDelete,
                                    builder: (context, isDelete, child) {
                                      return InkWell(
                                        onLongPress: () {
                                          _selectedWatching.value = {index};
                                          _isSelectedWatchingToDelete.value =
                                              true;
                                          preDeleteWatching.add(
                                            movieWatching
                                                .combineDetailAndWatch
                                                .movieSlug,
                                          );
                                        },
                                        child: ValueListenableBuilder(
                                          valueListenable: _selectedWatching,
                                          builder: (context, selectedPositions, child) {
                                            final isThisSelected =
                                                selectedPositions.contains(
                                                  index,
                                                );
                                            return isDelete
                                                ? AnimatedScale(
                                                    scale: isThisSelected
                                                        ? 0.8
                                                        : 1.0,
                                                    duration: const Duration(
                                                      milliseconds: 100,
                                                    ),
                                                    child: WatchingMovieWidget(
                                                      movieWatching:
                                                          movieWatching,
                                                      onChoose: (combine) {
                                                        if (isThisSelected) {
                                                          selectedPositions
                                                              .remove(index);
                                                          preDeleteWatching
                                                              .remove(
                                                                combine
                                                                    .movieSlug,
                                                              );
                                                        } else {
                                                          selectedPositions.add(
                                                            index,
                                                          );
                                                          preDeleteWatching.add(
                                                            combine.movieSlug,
                                                          );
                                                        }
                                                        _selectedWatching
                                                            .value = Set.of(
                                                          selectedPositions,
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : WatchingMovieWidget(
                                                    movieWatching:
                                                        movieWatching,
                                                    onChoose: (combine) {
                                                      context.push(
                                                        "/watch-movie",
                                                        extra: combine,
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                itemCount: watchingMovies.length,
                                scrollDirection: Axis.horizontal,
                              );
                            },
                          ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: _screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Constants.watchedMovie,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: _secondaryTitle,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _isSelectedWatchedToDelete,
                            builder: (context, value, child) {
                              return value == true
                                  ? InkWell(
                                      onTap: () async {
                                        _selectedWatched.value = {};
                                        _isSelectedWatchedToDelete.value =
                                            false;
                                        await _settingScreenManagement
                                            .deleteHistoryMovie(
                                              preDeleteWatched.toList(),
                                            );
                                        _settingScreenManagement
                                            .getWatchedMovie(true);
                                        preDeleteWatched.clear();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  : SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: _imageHeight,
                      child:
                          BlocSelector<
                            SettingScreenManagement,
                            SettingState,
                            (List<MovieWatching>, bool, String?)
                          >(
                            selector: (state) => (
                              state.watchedMovies,
                              state.watchedLoading,
                              state.watchedError,
                            ),
                            builder: (context, state) {
                              _isWatchedLoading = false;
                              if (state.$3 != null) {
                                return ErrorHandleWidget(
                                  onTap: () => _settingScreenManagement
                                      .getWatchedMovie(true),
                                );
                              }
                              if (state.$2 && state.$1.isEmpty) {
                                return const LoadingHandleWidget();
                              }
                              if (state.$1.isEmpty) {
                                return const EmptyDataWidget();
                              }
                              final watchedMovies = state.$1;
                              return ListView.builder(
                                key: PageStorageKey("watched_movie"),
                                controller: _watchedController,
                                itemExtent: _imageWidth,
                                itemBuilder: (context, index) {
                                  final movieWatched = watchedMovies[index];
                                  return ValueListenableBuilder(
                                    valueListenable: _isSelectedWatchedToDelete,
                                    builder: (context, isDelete, child) {
                                      return InkWell(
                                        onLongPress: () {
                                          _selectedWatched.value = {index};
                                          _isSelectedWatchedToDelete.value =
                                              true;
                                          preDeleteWatched.add(
                                            movieWatched
                                                .combineDetailAndWatch
                                                .movieSlug,
                                          );
                                        },
                                        child: ValueListenableBuilder(
                                          valueListenable: _selectedWatched,
                                          builder: (context, selectedPositions, child) {
                                            final isThisSelected =
                                                selectedPositions.contains(
                                                  index,
                                                );
                                            return isDelete
                                                ? AnimatedScale(
                                                    scale: isThisSelected
                                                        ? 0.9
                                                        : 1.0,
                                                    duration: const Duration(
                                                      milliseconds: 100,
                                                    ),
                                                    child: WatchedMovieWidget(
                                                      isSelected:
                                                          isThisSelected,
                                                      movieWatched:
                                                          movieWatched,
                                                      onChoose: (combine) {
                                                        if (isThisSelected) {
                                                          selectedPositions
                                                              .remove(index);
                                                          preDeleteWatched
                                                              .remove(
                                                                combine
                                                                    .movieSlug,
                                                              );
                                                        } else {
                                                          selectedPositions.add(
                                                            index,
                                                          );
                                                          preDeleteWatched.add(
                                                            combine.movieSlug,
                                                          );
                                                        }
                                                        _selectedWatched.value =
                                                            Set.of(
                                                              selectedPositions,
                                                            );
                                                      },
                                                    ),
                                                  )
                                                : WatchedMovieWidget(
                                                    isSelected: false,
                                                    movieWatched: movieWatched,
                                                    onChoose: (combine) {
                                                      context.push(
                                                        "/watch-movie",
                                                        extra: combine,
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                itemCount: watchedMovies.length,
                                scrollDirection: Axis.horizontal,
                              );
                            },
                          ),
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: _isLogout,
                      builder: (context, isLogout, child) {
                        return !isLogout
                            ? LogInOutButton(
                                onDo: () async {
                                  final result =
                                      await context.push("/login") as bool;
                                  _isLogout.value = result;
                                },
                                text: "Login",
                                icon: Icon(
                                  Icons.login,
                                  color: VColors.colorIcon,
                                ),
                                borderColor: VColors.colorIcon,
                                textColor: VColors.white,
                              )
                            : LogInOutButton(
                                onDo: () async {
                                  final result = await _settingScreenManagement
                                      .logout();
                                  _isLogout.value = !result;
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        Constants.logoutNotification,
                                      ),
                                    ),
                                  );
                                },
                                text: "Logout",
                                icon: Icon(Icons.logout, color: VColors.red),
                                borderColor: VColors.red,
                                textColor: VColors.red,
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
