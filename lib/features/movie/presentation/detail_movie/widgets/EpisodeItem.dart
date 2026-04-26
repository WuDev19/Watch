import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';

import '../../../../../core/colors/VColors.dart';

class EpisodeItem extends StatefulWidget {
  final List<EpisodeList> episodeList;
  final Function(String urlMovie) onWatch;

  const EpisodeItem({
    super.key,
    required this.episodeList,
    required this.onWatch,
  });

  @override
  State<EpisodeItem> createState() => _EpisodeItemState();
}

class _EpisodeItemState extends State<EpisodeItem> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.episodeList
          .map(
            (e) => GestureDetector(
              onTap: () {
                widget.onWatch(e.linkM3U8);
              },
              child: Card(
                color: VColors.greySearch,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Ep ${e.name}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
