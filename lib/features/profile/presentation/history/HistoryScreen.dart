import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/features/profile/presentation/history/state/HistoryState.dart';
import 'package:movie_app/features/profile/presentation/history/state_management/HistoryManagement.dart';
import 'package:movie_app/features/profile/presentation/history/widgets/HistoryItem.dart';
import 'package:movie_app/utils/constants.dart';

import '../common_widgets/SearchWidget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _movieController = ScrollController();
  bool _isLoadingMore = false;
  bool _isSearching = false;
  static const String emptyWatchHistory =
      "You haven't watched any movies recently.";
  static const String noMatchingResults = "No matching results found.";
  late final HistoryManagement _historyManagement;
  final ValueNotifier<Set<int>> _isRemove = ValueNotifier({});

  @override
  void initState() {
    super.initState();
    _historyManagement = context.read<HistoryManagement>();
    _historyManagement.getMyHistory(true);
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
        _historyManagement.searchMovieHistory(_searchController.text, false);
      } else {
        _historyManagement.getMyHistory(false);
      }
    }
  }

  void _onClearHistoryPressed(List<String> preDelete) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: VColors.blackBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: VColors.colorIcon, width: 2),
        ),
        title: Text(
          preDelete.isEmpty ? "Clear watch history" : "Delete movies",
          style: TextStyle(color: VColors.white),
        ),
        content: Text(
          preDelete.isEmpty
              ? "Are you sure you want to delete your entire watch history?"
              : "Are you sure you want to delete the selected movies?",
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
                _historyManagement.deleteAllMovieHistory();
              } else {
                await _historyManagement.deleteHistoryMovie(preDelete);
                _isRemove.value = {};
                _historyManagement.getMyHistory(true);
              }
            },
            child: Text(
              preDelete.isEmpty ? "Clear" : "Delete",
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
          "Watch History",
          style: TextStyle(color: VColors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            color: VColors.white,
            onPressed: () => _onClearHistoryPressed(preDelete),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchWidget(
              controller: _searchController,
              hint: "Search in the history list...",
              onSearch: (content) {
                _isSearching = true;
                _historyManagement.searchMovieHistory(content, true);
              },
              onEmpty: () {
                _isSearching = false;
                _historyManagement.getMyHistory(true);
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
      HistoryManagement,
      HistoryState,
      (List<MovieWatching>, bool, String?)
    >(
      selector: (state) =>
          (state.history, state.isLoadingHistory, state.errorHistory),
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
              _isSearching ? noMatchingResults : emptyWatchHistory,
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
                  child: HistoryItem(
                    title: movie.combineDetailAndWatch.movieWatch.movieName,
                    posterUrl:
                        Constants.baseImageUrl +
                        movie.combineDetailAndWatch.moviePoster,
                    progress: movie.progress,
                    onTap: () => context.push(
                      "/movie-details/${movie.combineDetailAndWatch.movieSlug}",
                    ),
                    onRemove: () {
                      if (removes.contains(index)) {
                        removes.remove(index);
                        preDelete.remove(movie.combineDetailAndWatch.movieSlug);
                        _isRemove.value = Set.of(removes);
                      } else {
                        removes.add(index);
                        preDelete.add(movie.combineDetailAndWatch.movieSlug);
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
