import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';

import '../../../../../core/colors/VColors.dart';

class EpisodeItem extends StatefulWidget {
  final List<EpisodeList> episodeList;
  final Function(EpisodeList currentEpisode) onWatch;
  final EpisodeList currentEpisode;

  const EpisodeItem({
    super.key,
    required this.episodeList,
    required this.onWatch,
    required this.currentEpisode,
  });

  @override
  State<EpisodeItem> createState() => _EpisodeItemState();
}

class _EpisodeItemState extends State<EpisodeItem> {
  late final ValueNotifier<int> _episodeValue;

  @override
  void initState() {
    super.initState();
    final index = widget.episodeList.indexOf(widget.currentEpisode);
    _episodeValue = ValueNotifier(index);
  }

  @override
  void dispose() {
    _episodeValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.episodeList
          .map(
            (e) => GestureDetector(
              onTap: () {
                widget.onWatch(e);
                _episodeValue.value = widget.episodeList.indexOf(e);
              },
              child: ValueListenableBuilder(
                valueListenable: _episodeValue,
                builder: (context, value, child) {
                  final currentIndex = widget.episodeList.indexOf(e);
                  return Card(
                    color: value != currentIndex
                        ? VColors.greySearch
                        : VColors.colorIcon,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ep ${e.name}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
