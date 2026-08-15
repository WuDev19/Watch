import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/EpisodeItem.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/EpisodeWidget.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/PageWidget.dart';

class ChooseEpisodeRoomDialog extends StatefulWidget {
  final MovieDetails movieDetail;
  final void Function(
    EpisodeList selectedEpisode,
    List<EpisodeList> currentListEpisode,
  )
  onConfirm;

  const ChooseEpisodeRoomDialog({
    super.key,
    required this.movieDetail,
    required this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required MovieDetails movieDetail,
    required void Function(
      EpisodeList selectedEpisode,
      List<EpisodeList> currentListEpisode,
    )
    onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ChooseEpisodeRoomDialog(
        movieDetail: movieDetail,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<ChooseEpisodeRoomDialog> createState() =>
      _ChooseEpisodeRoomDialogState();
}

class _ChooseEpisodeRoomDialogState extends State<ChooseEpisodeRoomDialog> {
  late ValueNotifier<Map<int, List<EpisodeList>>> _paginationEpisodeValues;
  late ValueNotifier<List<EpisodeList>> _episodeListValues;
  late ValueNotifier<EpisodeList> _selectedEpisodeValues;

  @override
  void initState() {
    super.initState();
    final firstServer = widget.movieDetail.episodes.first;
    _paginationEpisodeValues = ValueNotifier(firstServer.paginationEpisode);
    _episodeListValues = ValueNotifier(firstServer.paginationEpisode[1] ?? []);
    _selectedEpisodeValues = ValueNotifier(
      firstServer.paginationEpisode[1]!.first,
    );
  }

  @override
  void dispose() {
    _paginationEpisodeValues.dispose();
    _episodeListValues.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: VColors.blackBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 1, color: VColors.colorIcon),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.75),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Choose episode to watch together",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            EpisodeWidget(
              episodes: widget.movieDetail.episodes,
              onServerName: (episode) {
                _paginationEpisodeValues.value = episode.paginationEpisode;
                _episodeListValues.value = episode.paginationEpisode[1] ?? [];
                _selectedEpisodeValues.value =
                    episode.paginationEpisode[1]!.first;
              },
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _episodeListValues,
                      builder: (context, value, child) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: ValueListenableBuilder(
                            valueListenable: _selectedEpisodeValues,
                            builder: (context, currentEpisode, child) {
                              return EpisodeItem(
                                key: ValueKey(value),
                                episodeList: value,
                                currentEpisode: currentEpisode,
                                onWatch: (episode) {
                                  _selectedEpisodeValues.value = episode;
                                },
                                isInWatch: true,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable: _paginationEpisodeValues,
                      builder: (context, value, child) {
                        return PageWidget(
                          key: ValueKey(value),
                          pagination: value,
                          onChoosePage: (episodeList) {
                            _episodeListValues.value = episodeList;
                          },
                          currentPage: null,
                          isInWatch: false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: VColors.colorIcon,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: VColors.white),
                  ),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder(
                  valueListenable: _selectedEpisodeValues,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onConfirm(value, _episodeListValues.value);
                      },
                      child: const Text(
                        "Create room",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
