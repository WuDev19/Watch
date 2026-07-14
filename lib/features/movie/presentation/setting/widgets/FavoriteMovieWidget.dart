import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';

import '../../../../../core/colors/VColors.dart';

class FavoriteMovieWidget extends StatelessWidget {
  final FavoriteMovieModel _favoriteMovie;
  final bool _isSelected;
  final Function(String movieSlug) onChoose;

  const FavoriteMovieWidget({
    super.key,
    required FavoriteMovieModel favoriteMovie,
    required bool isSelected,
    required this.onChoose,
  }) : _favoriteMovie = favoriteMovie,
       _isSelected = isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChoose(_favoriteMovie.movieSlug);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              decoration: _isSelected
                  ? BoxDecoration(
                      borderRadius: const BorderRadiusGeometry.all(Radius.circular(20)),
                      border: BoxBorder.all(width: 2, color: Colors.red),
                    )
                  : null,
              child: ClipRRect(
                borderRadius: const BorderRadiusGeometry.all(
                  Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.network(
                    _favoriteMovie.thumbUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) =>
                        const Icon(Icons.error, color: VColors.colorIcon),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      final value =
                          loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!;
                      return Center(
                        child: CircularProgressIndicator(
                          value: value,
                          color: VColors.colorIcon,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Text(
              _favoriteMovie.movieName,
              style: TextStyle(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
