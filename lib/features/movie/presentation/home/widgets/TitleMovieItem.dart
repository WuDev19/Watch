import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatched.dart';
import 'package:movie_app/utils/constants.dart';

class TitleMovieItem extends StatelessWidget {
  final MovieWatched _movieWatched;

  const TitleMovieItem(this._movieWatched, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = Constants.getHeightScreen(context);
    final width = Constants.getWidthScreen(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: ClipRRect(
            borderRadius: const BorderRadiusGeometry.all(Radius.circular(20)),
            child: GestureDetector(
              onTap: () => _navigateToWatchScreen(context),
              child: Image.network(
                height: height,
                width: width,
                _movieWatched.thumbUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                    Constants.errorImage,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  final percent =
                      loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!;
                  return Center(
                    child: CircularProgressIndicator(
                      value: percent,
                      color: VColors.colorIcon,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 10,
          right: 30,
          child: GestureDetector(
            onTap: () => _navigateToWatchScreen(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.play_circle, color: VColors.colorIcon),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const Text(
                        "Continue Watching",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _movieWatched.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToWatchScreen(BuildContext context) {
    final movieWatch = MovieWatch(
      movieName: _movieWatched.name,
      currentEpisode: _movieWatched.currentEpisode,
      episodes: _movieWatched.episodes,
      currentListEpisode: _movieWatched.currentListEpisode,
    );
    final combine = CombineDetailAndWatch(
      movieSlug: _movieWatched.slug,
      moviePoster: _movieWatched.thumbUrl,
      total: _movieWatched.total,
      movieWatch: movieWatch,
    );
    context.push("/watch-movie", extra: combine);
  }
}
