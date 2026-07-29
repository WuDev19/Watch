import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/profile/presentation/favorite/state/FavoriteState.dart';
import 'package:movie_app/features/profile/presentation/favorite/state_management/FavoriteManagement.dart';
import 'package:movie_app/features/profile/presentation/favorite/widgets/FavoriteItem.dart';
import 'package:movie_app/utils/constants.dart';

import '../common_widgets/SearchWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _movieController = ScrollController();
  bool _isLoadingMore = false;
  bool _isSearching = false;
  static const String emptyFavoriteList =
      "You haven't added any movies to your favorites yet.";
  static const String noMatchingResults = "No matching results found.";
  late final FavoriteManagement _favoriteManagement;
  final ValueNotifier<Set<int>> _isRemove = ValueNotifier({});

  @override
  void initState() {
    super.initState();
    _favoriteManagement = context.read<FavoriteManagement>();
    _favoriteManagement.getMyFavoriteMovie(true);
    _movieController.addListener(_onLoadMore);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _movieController.removeListener(_onLoadMore);
    _movieController.dispose();
    _isRemove.dispose();
    super.dispose();
  }

  void _onLoadMore() {
    if (_isLoadingMore) return;
    if (_movieController.offset >=
        _movieController.position.maxScrollExtent * Constants.rateScroll) {
      _isLoadingMore = true;
      if (_isSearching) {
        _favoriteManagement.searchFavoriteMovie(_searchController.text, false);
      } else {
        _favoriteManagement.getMyFavoriteMovie(false);
      }
    }
  }

  void _onClearFavoritePressed(List<String> preDelete) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: VColors.blackBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: VColors.colorIcon, width: 2),
        ),
        title: Text(
          preDelete.isEmpty ? "Clear favorite list" : "Remove movies",
          style: TextStyle(color: VColors.white),
        ),
        content: Text(
          preDelete.isEmpty
              ? "Are you sure you want to remove all your favorite movies?"
              : "Are you sure you want to remove the selected movies?",
          style: TextStyle(color: VColors.white.withAlpha(155)),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.colorIcon,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text("Cancel", style: TextStyle(color: VColors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              if (preDelete.isEmpty) {
                _favoriteManagement.deleteAllFavoriteMovie();
              } else {
                await _favoriteManagement.deleteFavoriteMovie(preDelete);
                _isRemove.value = {};
                _favoriteManagement.getMyFavoriteMovie(true);
              }
            },
            child: Text(
              preDelete.isEmpty ? "Clear" : "Remove",
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> preDelete = [];
    return Scaffold(
      backgroundColor: VColors.blackBackground,
      appBar: AppBar(
        backgroundColor: VColors.blackBackground,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Favorites",
          style: TextStyle(color: VColors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            color: VColors.white,
            onPressed: () => _onClearFavoritePressed(preDelete),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchWidget(
              controller: _searchController,
              hint: "Search in the favorites list...",
              onSearch: (content) {
                _isSearching = true;
                _favoriteManagement.searchFavoriteMovie(content, true);
              },
              onEmpty: () {
                _isSearching = false;
                _favoriteManagement.getMyFavoriteMovie(true);
              },
            ),
            Expanded(child: _buildBody(preDelete)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(List<String> preDelete) {
    return BlocSelector<
        FavoriteManagement,
        FavoriteState,
        (List<FavoriteMovieModel>, bool, String?)
    >(
      selector: (state) =>
      (state.favorite, state.isLoadingFavorite, state.errorFavorite),
      builder: (context, state) {
        _isLoadingMore = false;
        if (state.$2 && state.$1.isEmpty) {
          return Center(
            child: LottieBuilder.asset(
              "assets/lottie/loading.json",
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          );
        }
        if (state.$3 != null) {
          print("Lỗi ${state.$3}");
          return Center(
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/images/try.png",
                width: 50,
                height: 50,
                color: VColors.colorIcon,
              ),
            ),
          );
        }
        if (state.$1.isEmpty) {
          return Center(
            child: Text(
              _isSearching ? noMatchingResults : emptyFavoriteList,
              style: TextStyle(color: VColors.white.withAlpha(150)),
            ),
          );
        }
        final items = state.$1;
        return MasonryGridView.count(
          controller: _movieController,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final movie = items[index];
            return ValueListenableBuilder(
              valueListenable: _isRemove,
              builder: (context, removes, child) {
                return AnimatedScale(
                  scale: removes.contains(index) ? 0.8 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: FavoriteItem(
                    title: movie.movieName,
                    posterUrl: movie.thumbUrl,
                    onTap: () => context.push(
                      "/movie-details/${movie.movieSlug}",
                    ),
                    onRemove: () {
                      if (removes.contains(index)) {
                        removes.remove(index);
                        preDelete.remove(movie.movieSlug);
                        _isRemove.value = Set.of(removes);
                      } else {
                        removes.add(index);
                        preDelete.add(movie.movieSlug);
                        _isRemove.value = Set.of(removes);
                      }
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}