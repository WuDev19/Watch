import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';

import '../../../../../core/colors/VColors.dart';

class FavoriteMovieWidget extends StatelessWidget {
  final FavoriteMovieModel _favoriteMovie;

  const FavoriteMovieWidget({
    super.key,
    required FavoriteMovieModel favoriteMovie,
  }) : _favoriteMovie = favoriteMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.all(Radius.circular(20)),
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
          Text(
            _favoriteMovie.movieName,
            style: TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
