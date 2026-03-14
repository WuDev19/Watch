import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RelatedMovieItem extends StatelessWidget {
  final String _moviePoster;

  const RelatedMovieItem({super.key, required String moviePoster})
    : _moviePoster = moviePoster;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: _moviePoster,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholder: (context, url) => Container(color: Colors.grey[300]),
          ),
        ),
      ),
    );
  }
}
