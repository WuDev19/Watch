import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _onDetail(_movieSlug),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
            child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: _moviePoster,
              fit: BoxFit.cover,
              memCacheWidth: 500,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  color: Colors.black,
                  child: Text(
                    "Internet issues",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              placeholder: (context, url) =>
                  Container(color: Colors.grey[300]),
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
