import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

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
          child: Image.network(
            _moviePoster,
            fit: BoxFit.cover,
            errorBuilder: (context, url, error) => const Icon(Icons.error),
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
    );
  }
}
