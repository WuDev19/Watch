import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';

import '../../../../../core/colors/VColors.dart';

class EpisodeItem extends StatefulWidget {
  final List<EpisodeList> episodeList;

  const EpisodeItem({super.key, required this.episodeList});

  @override
  State<EpisodeItem> createState() => _EpisodeItemState();
}

class _EpisodeItemState extends State<EpisodeItem> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.episodeList
          .map(
            (e) => Card(
              color: VColors.greySearch,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ep ${e.name}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
