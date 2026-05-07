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
import '../../domain/models/FavoriteMovieModel.dart';
import '../detail_movie/widgets/EpisodeItem.dart';
import '../detail_movie/widgets/EpisodeWidget.dart';
import '../detail_movie/widgets/PageWidget.dart';

class WatchMovieScreen extends StatefulWidget {
  final CombineDetailAndWatch? combineDetailAndWatch;

  const WatchMovieScreen({super.key, required this.combineDetailAndWatch});

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen>
    with WidgetsBindingObserver {
  BetterPlayerController? _betterPlayerController;
  late ValueNotifier<Map<int, List<EpisodeList>>> _paginationEpisodeValues;
  late ValueNotifier<List<EpisodeList>> _episodeListValues;
  late ValueNotifier<bool> _addToFavoriteValues;
  late WatchMovieManagement _watchMovieManagement;
  final GlobalKey _betterPlayerKey = GlobalKey();
  bool _isInPipMode = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      this,
    ); //đăng kí lắng nghe sự kiện hệ thống
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
      _episodeListValues = ValueNotifier(
        widget.combineDetailAndWatch!.movieWatch.currentListEpisode,
      );
      _addToFavoriteValues = ValueNotifier(false);
      _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          autoPlay: false,
          allowedScreenSleep: false,
          fit: BoxFit.cover,
          handleLifecycle: false,
          deviceOrientationsOnFullScreen: [
            //khi fullscreen thì chỉ cho ngang
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ],
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          //khi hết phim hoặc thu nhỏ thì sẽ cho quay về dọc
          systemOverlaysAfterFullScreen: [],
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            enablePip: true,
            pipMenuIcon: Icons.picture_in_picture,
          ),
        ),
      );

      _betterPlayerController!.addEventsListener((event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.pipStart) {
          _isInPipMode = true;
        } else if (event.betterPlayerEventType ==
            BetterPlayerEventType.pipStop) {
          _isInPipMode = false;
        }
      });

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

      _watchMovieManagement
          .checkFavoriteMovie(widget.combineDetailAndWatch!.movieSlug)
          .then((value) {
            _addToFavoriteValues.value = value;
            _isFavorite = value;
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _enterPipMode();
    } else if (state == AppLifecycleState.paused) {
      if (_betterPlayerController?.isPlaying() == true) {
        await _betterPlayerController?.pause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_betterPlayerController?.isPlaying() == false) {
        await _betterPlayerController?.play();
      }
    }
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
                      child: BetterPlayer(
                        key: _betterPlayerKey,
                        controller: _betterPlayerController!,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Watching: ${widget.combineDetailAndWatch!.movieWatch.movieName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: secondaryTitle,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            if (_isFavorite) {
                              _watchMovieManagement.deleteFavoriteMovie(
                                widget.combineDetailAndWatch!.movieSlug,
                              );
                            } else {
                              _watchMovieManagement.saveFavoriteMovie(
                                FavoriteMovieModel(
                                  movieName: widget
                                      .combineDetailAndWatch!
                                      .movieWatch
                                      .movieName,
                                  movieSlug:
                                      widget.combineDetailAndWatch!.movieSlug,
                                  thumbUrl:
                                      widget.combineDetailAndWatch!.moviePoster,
                                ),
                              );
                            }
                            _isFavorite = !_isFavorite;
                            _addToFavoriteValues.value = _isFavorite;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: _addToFavoriteValues,
                            builder: (context, value, child) {
                              return value == true
                                  ? Icon(
                                      Icons.favorite,
                                      color: VColors.colorIcon,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: VColors.colorIcon,
                                    );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
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
                                widget
                                        .combineDetailAndWatch!
                                        .movieWatch
                                        .currentEpisode =
                                    currentEpisode;
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

  void _enterPipMode() async {
    bool isSupported =
        await _betterPlayerController?.isPictureInPictureSupported() ?? false;
    if (isSupported) {
      if (_betterPlayerController!.isPlaying() == true) {
        if (_betterPlayerController!.isFullScreen) {
          _betterPlayerController!.exitFullScreen();
          await Future.delayed(const Duration(seconds: 400));
        }
        await _betterPlayerController?.enablePictureInPicture(_betterPlayerKey);
      }
    }
  }

  Future<void> _changeEpisode(EpisodeList currentEpisode) async {
    if (_isInPipMode) {
      await _betterPlayerController?.disablePictureInPicture();
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); //đợi một chút sau khi đóng pip
    }
    await _betterPlayerController?.pause(); //dừng video cũ để tránh lỗi
    BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
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
