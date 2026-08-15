import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';

class TrendingMovieItem extends StatelessWidget {
  final String _moviePoster;
  final String _movieName;
  final String _movieSlug;
  final double _star;
  final void Function(String slug) _onDetail;

  const TrendingMovieItem({
    super.key,
    required String moviePoster,
    required String movieName,
    required String movieSlug,
    required double movieStar,
    required void Function(String slug) onDetail,
  }) : _moviePoster = moviePoster,
       _movieName = movieName,
       _movieSlug = movieSlug,
       _star = movieStar,
       _onDetail = onDetail;

  @override
  Widget build(BuildContext context) {
    print("movie url: $_moviePoster");
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _onDetail(_movieSlug),
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 5, blurRadius: 5),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
              child: Image.network(
                height: double.infinity,
                width: double.infinity,
                _moviePoster,
                fit: BoxFit.cover,
                cacheWidth: 500,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          VColors.greySearch.withValues(alpha: 0.6),
                          VColors.greySearch.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.white.withValues(alpha: 0.25),
                      size: 36,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: VColors.colorIcon),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(150),
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text(
                    _star.toStringAsFixed(1),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(150),
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            ),
            child: Text(
              _movieName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
