import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatching.dart';
import 'package:movie_app/utils/constants.dart';

import '../../../../../core/colors/VColors.dart';

class WatchingMovieWidget extends StatelessWidget {
  final MovieWatching _movieWatching;
  final bool _isSelected;
  final Function(CombineDetailAndWatch combine) _onChoose;

  const WatchingMovieWidget({
    super.key,
    required MovieWatching movieWatching,
    required bool isSelected,
    required Function(CombineDetailAndWatch combine) onChoose,
  }) : _movieWatching = movieWatching,
       _isSelected = isSelected,
       _onChoose = onChoose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onChoose(_movieWatching.combineDetailAndWatch);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
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
                        Constants.baseImageUrl +
                            _movieWatching.combineDetailAndWatch.moviePoster,
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
                Positioned(
                  left: 5,
                  right: 5,
                  bottom: 10.0,
                  child: LinearProgressIndicator(
                    value: _movieWatching.progress,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: VColors.colorIcon,
                  ),
                ),
              ],
            ),
            Text(
              _movieWatching.combineDetailAndWatch.movieWatch.movieName,
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
