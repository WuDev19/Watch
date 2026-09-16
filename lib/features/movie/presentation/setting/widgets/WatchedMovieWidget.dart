import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';
import '../../../domain/models/CombineDetailAndWatch.dart';
import '../../../domain/models/MovieWatching.dart';

class WatchedMovieWidget extends StatelessWidget {
  final MovieWatching _movieWatched;
  final bool _isSelected;
  final Function(CombineDetailAndWatch combine) _onChoose;

  const WatchedMovieWidget({
    super.key,
    required MovieWatching movieWatched,
    required bool isSelected,
    required Function(CombineDetailAndWatch combine) onChoose,
  }) : _movieWatched = movieWatched,
       _isSelected = isSelected,
       _onChoose = onChoose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onChoose(_movieWatched.combineDetailAndWatch);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              decoration: _isSelected
                  ? BoxDecoration(
                      borderRadius: const BorderRadiusGeometry.all(
                        Radius.circular(20),
                      ),
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
                    _movieWatched.combineDetailAndWatch.moviePoster,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) =>
                        const Icon(Icons.error, color: VColors.colorIcon),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: VColors.colorIcon,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Text(
              _movieWatched.combineDetailAndWatch.movieWatch.movieName,
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
