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

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  BetterPlayerController? _betterPlayerController;
  late ValueNotifier<Map<int, List<EpisodeList>>> _paginationEpisodeValues;
  late ValueNotifier<List<EpisodeList>> _episodeListValues;
  late ValueNotifier<bool> _addToFavoriteValues;

  late ValueNotifier<bool> _isPlayerReadyValues;
  late WatchMovieManagement _watchMovieManagement;
  final GlobalKey _betterPlayerKey = GlobalKey();

  final TextEditingController _commentController = TextEditingController();
  bool _isInPipMode = false;
  bool _isFavorite = false;

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
      _episodeListValues = ValueNotifier(
        widget.combineDetailAndWatch!.movieWatch.currentListEpisode,
      );
      _addToFavoriteValues = ValueNotifier(false);
      _isPlayerReadyValues = ValueNotifier(false);

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
          controlsConfiguration: BetterPlayerControlsConfiguration(
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
        } else if (event.betterPlayerEventType ==
            BetterPlayerEventType.initialized) {
          //video đã sẵn sàng để phát -> ẩn poster/loading overlay
          if (mounted) _isPlayerReadyValues.value = true;
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
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
        check().then((value) => print("pippp: $value")).catchError((e) {
          print("error: $e");
        });
      });

      _watchMovieManagement
          .checkFavoriteMovie(widget.combineDetailAndWatch!.movieSlug)
          .then((value) {
            _addToFavoriteValues.value = value;
            _isFavorite = value;
          });
    }
  }

  Future<bool> check() =>
      _betterPlayerController!.isPictureInPictureSupported();

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    ); //cho về trạng thái ban đầu trước khi set mode immersive
    _betterPlayerController?.dispose();
    _episodeListValues.dispose();
    _paginationEpisodeValues.dispose();
    _isPlayerReadyValues.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    final combine = widget.combineDetailAndWatch;
    return Scaffold(
      backgroundColor: VColors.blackBackground,
      body: combine != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPlayer(combine),
                  const SizedBox(height: 16),
                  _buildTitleAndActions(combine, secondaryTitle),
                  const SizedBox(height: 20),
                  _buildSectionHeader("Episodes", secondaryTitle),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: EpisodeWidget(
                      episodes: combine.movieWatch.episodes,
                      onServerName: (episode) {
                        _paginationEpisodeValues.value =
                            episode.paginationEpisode;
                        _episodeListValues.value =
                            episode.paginationEpisode[1] ?? [];
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: EpisodeItem(
                            key: ValueKey(value),
                            episodeList: value,
                            currentEpisode: combine.movieWatch.currentEpisode,
                            onWatch: (currentEpisode) {
                              combine.movieWatch.currentEpisode =
                                  currentEpisode;
                              _watchMovieManagement.saveMovieHistory(
                                MovieHistoryModel(
                                  currentEpisode:
                                      MethodHelperUtils.getCurrentEpisode(
                                        currentEpisode,
                                      ),
                                  combineDetailAndWatch: combine,
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
                          currentPage: combine.movieWatch.currentListEpisode,
                          isInWatch: true,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildDivider(),
                  const SizedBox(height: 16),
                  _buildCommentSection(secondaryTitle),
                  const SizedBox(height: 24),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildPlayer(CombineDetailAndWatch combine) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              Constants.baseImageUrl + combine.moviePoster,
              fit: BoxFit.cover,
            ),
            BetterPlayer(
              key: _betterPlayerKey,
              controller: _betterPlayerController!,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isPlayerReadyValues,
              builder: (context, isReady, child) {
                if (isReady) return const SizedBox.shrink();
                return Container(
                  color: Colors.black.withAlpha(90),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              },
            ),
            Positioned(
              left: 10,
              child: GestureDetector(
                onTap: _enterPipMode,
                child: Icon(Icons.picture_in_picture, color: VColors.colorIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndActions(
    CombineDetailAndWatch combine,
    double secondaryTitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "Watching: ${combine.movieWatch.movieName}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: secondaryTitle,
              ),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (_isFavorite) {
                _watchMovieManagement.deleteFavoriteMovie(combine.movieSlug);
              } else {
                _watchMovieManagement.saveFavoriteMovie(
                  FavoriteMovieModel(
                    movieName: combine.movieWatch.movieName,
                    movieSlug: combine.movieSlug,
                    thumbUrl: Constants.baseImageUrl + combine.moviePoster,
                  ),
                );
              }
              _isFavorite = !_isFavorite;
              _addToFavoriteValues.value = _isFavorite;
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: ValueListenableBuilder(
                valueListenable: _addToFavoriteValues,
                builder: (context, value, child) {
                  return Icon(
                    value == true ? Icons.favorite : Icons.favorite_border,
                    color: VColors.colorIcon,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              _watchMovieManagement.download(
                url: combine.movieWatch.currentEpisode.linkM3U8,
                name: combine.movieWatch.movieName,
                episodeName: combine.movieWatch.currentEpisode.name,
                movieSlug: combine.movieSlug,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.download, color: VColors.colorIcon),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 1,
      color: Colors.white.withAlpha(25),
    );
  }

  Widget _buildCommentSection(double secondaryTitle) {
    final sampleComments = [
      {
        "name": "Minh Anh",
        "time": "2 giờ trước",
        "comment": "Phim hay quá, cảnh cuối xúc động thật sự!",
      },
      {
        "name": "Quốc Huy",
        "time": "5 giờ trước",
        "comment": "Tập này diễn viên diễn tốt hơn hẳn tập trước.",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments",
            style: TextStyle(
              color: Colors.white,
              fontSize: secondaryTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // Ô nhập bình luận
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white70, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Viết bình luận...",
                            hintStyle: TextStyle(color: Colors.white38),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: VColors.colorIcon,
                          size: 20,
                        ),
                        onPressed: () {
                          _commentController.clear();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...sampleComments.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white70, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              c["name"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              c["time"]!,
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c["comment"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _enterPipMode() async {
    bool isSupported =
        await _betterPlayerController?.isPictureInPictureSupported() ?? false;
    if (isSupported) {
      if (_betterPlayerController!.isPlaying() == true) {
        if (_betterPlayerController!.isFullScreen) {
          _betterPlayerController!.exitFullScreen();
          await Future.delayed(const Duration(milliseconds: 400));
        }
        await _betterPlayerController?.enablePictureInPicture(_betterPlayerKey);
      }
    }
  }

  Future<void> _changeEpisode(EpisodeList currentEpisode) async {
    _isPlayerReadyValues.value = false;
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
