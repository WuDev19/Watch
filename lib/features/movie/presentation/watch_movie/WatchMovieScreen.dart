import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';
import '../../../../utils/constants.dart';
import '../../domain/models/EpisodeList.dart';
import '../detail_movie/widgets/EpisodeItem.dart';
import '../detail_movie/widgets/EpisodeWidget.dart';
import '../detail_movie/widgets/PageWidget.dart';

class WatchMovieScreen extends StatefulWidget {
  final MovieWatch? movieWatch;
  final String? trailerUrl;

  const WatchMovieScreen({
    super.key,
    required this.movieWatch,
    this.trailerUrl,
  });

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  BetterPlayerController? _betterPlayerController;
  late ValueNotifier<Map<int, List<EpisodeList>>> _paginationEpisodeValues;
  late ValueNotifier<List<EpisodeList>> _episodeListValues;

  @override
  void initState() {
    super.initState();
    if (widget.movieWatch != null) {
      _paginationEpisodeValues = ValueNotifier(
        widget.movieWatch!.episodes.first.paginationEpisode,
      );
      _episodeListValues = ValueNotifier(widget.movieWatch!.currentListEpisode);
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
              widget.movieWatch!.currentEpisode.linkM3U8,
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
      body: widget.movieWatch != null
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
                        widget.movieWatch!.movieName,
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
                        episodes: widget.movieWatch!.episodes,
                        onServerName: (episode) {
                          _paginationEpisodeValues.value =
                              episode.paginationEpisode;
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
                              currentEpisode: widget.movieWatch!.currentEpisode,
                              onWatch: (currentEpisode) {
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
                            pagination: value,
                            onChoosePage: (episodeList) {
                              _episodeListValues.value = episodeList;
                            },
                            currentPage: widget.movieWatch!.currentListEpisode,
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
