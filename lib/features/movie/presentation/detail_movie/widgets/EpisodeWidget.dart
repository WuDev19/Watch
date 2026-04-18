import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/Episode.dart';

import '../../../../../core/colors/VColors.dart';

class EpisodeWidget extends StatefulWidget {
  final List<Episode> episodes;
  final Function(Episode episode) onServerName;

  const EpisodeWidget({
    super.key,
    required this.episodes,
    required this.onServerName,
  });

  @override
  State<EpisodeWidget> createState() => _EpisodeWidgetState();
}

class _EpisodeWidgetState extends State<EpisodeWidget> {
  int _oldIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final episode = widget.episodes[index];
          return Center(
            child: InkWell(
              onTap: () {
                widget.onServerName(episode);
                if (_oldIndex != index) {
                  _oldIndex = index;
                  setState(() {
                    episode.isSelected = true;
                    widget.episodes[_oldIndex].isSelected = false;
                  });
                }
              },
              child: Card(
                margin: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                ),
                color: episode.isSelected
                    ? VColors.greySearch
                    : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    episode.serverName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.episodes.length,
      ),
    );
  }
}
