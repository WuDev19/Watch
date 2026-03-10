import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class GenreItem extends StatelessWidget {
  final String _genre;

  const GenreItem({super.key, required String genre}) : _genre = genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusGeometry.all(Radius.circular(20)),
        border: BoxBorder.all(width: 1, color: VColors.colorIcon),
        color: VColors.greySearch,
      ),
      child: Text(_genre, style: TextStyle(color: Colors.white)),
    );
  }
}
