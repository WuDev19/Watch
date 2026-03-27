import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class SearchResultItem extends StatelessWidget {
  final String _moviePoster;
  final String _movieName;
  final int _movieYear;

  const SearchResultItem({
    super.key,
    required String moviePoster,
    required String movieName,
    required int movieYear,
  }) : _moviePoster = moviePoster,
       _movieName = movieName,
       _movieYear = movieYear;

  @override
  Widget build(BuildContext context) {
    double widthCache = MediaQuery.of(context).size.width / 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Image.network(
              _moviePoster,
              cacheWidth: (widthCache * MediaQuery.of(context).devicePixelRatio)
                  .round(),
              //cache với dung lượng này để tối ưu ram
              fit: BoxFit.contain,
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
        SizedBox(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: _movieName),
              TextSpan(text: " ($_movieYear)"),
            ],
          ),
        ),
      ],
    );
  }
}
