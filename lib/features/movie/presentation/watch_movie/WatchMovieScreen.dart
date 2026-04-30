import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state_management/WatchMovieManagement.dart';
import 'package:movie_app/utils/MethodHelperUtils.dart';
import '../../../../utils/constants.dart';
import '../../domain/models/EpisodeList.dart';
import '../detail_movie/widgets/EpisodeItem.dart';
import '../detail_movie/widgets/EpisodeWidget.dart';
import '../detail_movie/widgets/PageWidget.dart';

class WatchMovieScreen extends StatefulWidget {
  final CombineDetailAndWatch? combineDetailAndWatch;

  const WatchMovieScreen({super.key, required this.combineDetailAndWatch});

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  BetterPlayerController? _betterPlayerController;
  late ValueNotifier<Map<int, List<EpisodeList>>> _paginationEpisodeValues;
  late ValueNotifier<List<EpisodeList>> _episodeListValues;
  late WatchMovieManagement _watchMovieManagement;

  @override
  void initState() {
    super.initState();
    if (widget.combineDetailAndWatch != null) {
      _watchMovieManagement = context.read<WatchMovieManagement>();
      _paginationEpisodeValues = ValueNotifier(
        widget
            .combineDetailAndWatch!
            .movieWatch
            .episodes
            .first
            .paginationEpisode,
      );
      print(
        "episode list - ${widget.combineDetailAndWatch!.movieWatch.currentListEpisode}",
      );
      _episodeListValues = ValueNotifier(
        widget.combineDetailAndWatch!.movieWatch.currentListEpisode,
      );
      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: false,
          allowedScreenSleep: false,
          fit: BoxFit.cover,
          deviceOrientationsOnFullScreen: [
            //khi fullscreen thì chỉ cho ngang
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ],
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          //khi hết phim hoặc thu nhỏ thì sẽ cho quay về dọc
          systemOverlaysAfterFullScreen: [],
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.delayed(const Duration(milliseconds: 1000));
        BetterPlayerDataSource betterPlayerDataSource =
            BetterPlayerDataSource.network(
              widget.combineDetailAndWatch!.movieWatch.currentEpisode.linkM3U8,
              cacheConfiguration: BetterPlayerCacheConfiguration(
                useCache: true,
                maxCacheSize: 100 * 1024 * 1024,
                maxCacheFileSize: 10 * 1024 * 1024,
              ),
            );
        await _betterPlayerController!.setupDataSource(betterPlayerDataSource);
        _betterPlayerController!.enterFullScreen();
        _betterPlayerController!.play();
      });
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    ); //cho về trạng thái ban đầu trước khi set mode immersive
    _betterPlayerController?.dispose();
    _episodeListValues.dispose();
    _paginationEpisodeValues.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    return Scaffold(
      body: widget.combineDetailAndWatch != null
          ? Container(
              height: Constants.getHeightScreen(context),
              color: VColors.blackBackground,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadiusGeometry.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      child: BetterPlayer(controller: _betterPlayerController!),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.combineDetailAndWatch!.movieWatch.movieName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Episodes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: secondaryTitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: EpisodeWidget(
                        episodes:
                            widget.combineDetailAndWatch!.movieWatch.episodes,
                        onServerName: (episode) {
                          _paginationEpisodeValues.value =
                              episode.paginationEpisode;
                          _episodeListValues.value =
                              episode.paginationEpisode[1] ?? [];
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _episodeListValues,
                      builder: (context, value, child) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: EpisodeItem(
                              key: ValueKey(value),
                              episodeList: value,
                              currentEpisode: widget
                                  .combineDetailAndWatch!
                                  .movieWatch
                                  .currentEpisode,
                              onWatch: (currentEpisode) {
                                _watchMovieManagement.saveMovieHistory(
                                  MovieHistoryModel(
                                    currentEpisode:
                                        MethodHelperUtils.getCurrentEpisode(
                                          currentEpisode,
                                        ),
                                    combineDetailAndWatch:
                                        widget.combineDetailAndWatch!,
                                  ),
                                );
                                _changeEpisode(currentEpisode);
                              },
                              isInWatch: true,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable: _paginationEpisodeValues,
                      builder: (context, value, child) {
                        return Center(
                          child: PageWidget(
                            key: ValueKey(value),
                            pagination: value,
                            onChoosePage: (episodeList) {
                              _episodeListValues.value = episodeList;
                            },
                            currentPage: widget
                                .combineDetailAndWatch!
                                .movieWatch
                                .currentListEpisode,
                            isInWatch: true,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  Future<void> _changeEpisode(EpisodeList currentEpisode) async {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
      // lấy nguôn khác set vào controller hiện tại
      currentEpisode.linkM3U8,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
      ),
    );
    await _betterPlayerController!.setupDataSource(dataSource);
    _betterPlayerController!.play();
  }
}
