import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/profile/presentation/favorite/widgets/FavoriteItem.dart';
import 'package:movie_app/features/profile/presentation/common_widgets/SearchWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = "";

  // TODO: thay bằng data thật từ cubit/repository của bạn.
  final List<Map<String, dynamic>> _favorites = [
    {
      "id": "1",
      "title": "Inception",
      "poster":
          "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg",
      "rating": 8.8,
      "year": "2010",
    },
    {
      "id": "2",
      "title": "Interstellar",
      "poster":
          "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
      "rating": 8.6,
      "year": "2014",
    },
    {
      "id": "3",
      "title": "The Dark Knight",
      "poster":
          "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
      "rating": 9.0,
      "year": "2008",
    },
    {
      "id": "4",
      "title": "Parasite",
      "poster":
          "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
      "rating": 8.5,
      "year": "2019",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _favorites;
    return _favorites
        .where((m) => (m["title"] as String).toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchWidget(
              controller: _searchController,
              hint: "Search in the favorites list...",
              onSearch: (content) {},
              onEmpty: () {},
            ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    final items = _filtered;

    if (items.isEmpty) {
      return Center(
        child: Text(
          _query.isEmpty
              ? "You don't have any favorite movies yet."
              : "No matching results found.",
          style: TextStyle(color: VColors.white.withAlpha(150)),
        ),
      );
    }

    return MasonryGridView.count(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final movie = items[index];
        return FavoriteItem(
          title: movie["title"],
          posterUrl: movie["poster"],
          onTap: () {
            // TODO: điều hướng sang màn hình chi tiết phim
          },
          onRemove: () {
            setState(
              () => _favorites.removeWhere((m) => m["id"] == movie["id"]),
            );
          },
        );
      },
    );
  }
}
