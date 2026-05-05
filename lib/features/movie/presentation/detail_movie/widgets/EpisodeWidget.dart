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
  late ValueNotifier<int> _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = ValueNotifier(0);
  }

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
                _currentIndex.value = index;
              },
              child: ValueListenableBuilder(valueListenable: _currentIndex,
                builder: (context, value, child) {
                  return Card(
                    margin: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(Radius.circular(
                          10)),
                    ),
                    color: index == value
                        ? VColors.colorIcon
                        : VColors.greySearch,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        episode.serverName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },

              ),
            ),
          );
        },
        itemCount: widget.episodes.length,
      ),
    );
  }
}
