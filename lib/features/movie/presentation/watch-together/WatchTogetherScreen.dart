import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/RoomCreation.dart';
import 'package:movie_app/features/movie/domain/models/RoomMember.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/LoadingHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/watch/function/MovieFunctions.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/watch/widgets/MoviePlayer.dart';
import 'package:movie_app/features/movie/presentation/watch-together/state/TogetherState.dart';
import 'package:movie_app/features/movie/presentation/watch-together/state_management/WatchTogetherManagement.dart';
import 'package:movie_app/features/movie/presentation/watch-together/widgets/RoomMemberCard.dart';

import '../../../../utils/MethodHelperUtils.dart';
import '../../../../utils/constants.dart';
import '../../domain/models/EpisodeList.dart';
import '../../domain/models/MovieHistoryModel.dart';
import '../detail_movie/widgets/EpisodeItem.dart';
import '../detail_movie/widgets/EpisodeWidget.dart';
import '../detail_movie/widgets/PageWidget.dart';

class WatchTogetherScreen extends StatefulWidget {
  final RoomCreation roomCreation;

  const WatchTogetherScreen({super.key, required this.roomCreation});

  @override
  State<WatchTogetherScreen> createState() => _WatchTogetherScreenState();
}

class _WatchTogetherScreenState extends State<WatchTogetherScreen> {
  late WatchTogetherManagement _watchMovieManagement;
  late BetterPlayerController _betterPlayerController;
  ValueNotifier<Map<int, List<EpisodeList>>>? _paginationEpisodeValues;
  ValueNotifier<List<EpisodeList>>? _episodeListValues;
  final ValueNotifier<bool> _isHostListener = ValueNotifier(false);
  final GlobalKey _betterPlayerKey = GlobalKey();

  bool _isInPipMode = false;
  num cacheCurrentTime = 0;
  bool exist = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _watchMovieManagement = context.read<WatchTogetherManagement>();
    _watchMovieManagement.checkRoomWatching(widget.roomCreation.roomId).then((
      roomExist,
    ) {
      if (roomExist) {
        if (widget.roomCreation.isHost) {
          _paginationEpisodeValues = ValueNotifier(
            widget
                .roomCreation
                .combine!
                .movieWatch
                .episodes
                .first
                .paginationEpisode,
          );
          _episodeListValues = ValueNotifier(
            widget.roomCreation.combine!.movieWatch.currentListEpisode,
          );
          _isHostListener.value = true;
        }

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

        _betterPlayerController.addEventsListener(_onPlayerEvent);

        _watchMovieManagement.watching(widget.roomCreation.roomId);

        setState(() {
          exist = true;
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  void _onPlayerEvent(BetterPlayerEvent event) async {
    if (event.betterPlayerEventType == BetterPlayerEventType.pipStart) {
      _isInPipMode = true;
    } else if (event.betterPlayerEventType == BetterPlayerEventType.pipStop) {
      _isInPipMode = false;
    } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      _watchMovieManagement.updateRoom(
        roomId: widget.roomCreation.roomId,
        isPlaying: false,
      );
    } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
      _watchMovieManagement.updateRoom(
        roomId: widget.roomCreation.roomId,
        isPlaying: true,
        currentTime: _betterPlayerController
            .videoPlayerController
            ?.value
            .position
            .inMilliseconds,
      );
    } else if (event.betterPlayerEventType == BetterPlayerEventType.seekTo) {
      _watchMovieManagement.updateRoom(
        roomId: widget.roomCreation.roomId,
        currentTime: _betterPlayerController
            .videoPlayerController
            ?.value
            .position
            .inMilliseconds,
      );
    } else if (event.betterPlayerEventType == BetterPlayerEventType.setSpeed) {
      _watchMovieManagement.updateRoom(
        roomId: widget.roomCreation.roomId,
        playbackRate:
            _betterPlayerController.videoPlayerController?.value.speed,
      );
    } else if (event.betterPlayerEventType ==
        BetterPlayerEventType.initialized) {
      final roomWatching = _watchMovieManagement.state.roomWatching;
      if (roomWatching == null) return;
      final controller = _betterPlayerController.videoPlayerController;

      if (cacheCurrentTime != roomWatching.currentTime) {
        cacheCurrentTime = roomWatching.currentTime;
        await controller?.seekTo(
          Duration(milliseconds: roomWatching.currentTime.toInt()),
        );
      }
      await controller?.setSpeed(roomWatching.playbackRate.toDouble());
      if (roomWatching.isPlaying) {
        await controller?.play();
      }
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    ); //cho về trạng thái ban đầu trước khi set mode immersive
    _betterPlayerController.dispose();
    _episodeListValues?.dispose();
    _paginationEpisodeValues?.dispose();
    _isHostListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roomCreation = widget.roomCreation;
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    return loading
        ? LoadingHandleWidget()
        : !exist
        ? Scaffold(
            body: _buildEmptyRoom(),
          )
        : PopScope(
            canPop: !roomCreation.isHost,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;

              if (roomCreation.isHost) {
                await _showDialog(context, roomCreation.roomId);
              }
            },
            child: Scaffold(
              backgroundColor: VColors.blackBackground,
              appBar: AppBar(
                backgroundColor: VColors.blackBackground,
                elevation: 0,
                title: const Text(
                  "Watch together",
                  style: TextStyle(color: Colors.white),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: ListView(
                children: [
                  MoviePlayer(
                    betterPlayerController: _betterPlayerController,
                    betterPlayerKey: _betterPlayerKey,
                    enterPipMode: () => MovieFunctions.enterPipMode(
                      betterPlayerController: _betterPlayerController,
                      betterPlayerKey: _betterPlayerKey,
                    ),
                  ),
                  BlocListener<WatchTogetherManagement, TogetherState>(
                    listenWhen: (previous, current) {
                      final oldData = previous.roomWatching;
                      final newData = current.roomWatching;
                      return (oldData?.isPlaying != newData?.isPlaying ||
                          oldData?.currentTime != newData?.currentTime ||
                          oldData?.movieUrl != newData?.movieUrl ||
                          oldData?.playbackRate != newData?.playbackRate);
                    },
                    listener: (context, state) async {
                      final roomWatching = state.roomWatching;
                      if (roomWatching == null) return;

                      if (roomWatching.movieUrl !=
                          _betterPlayerController.betterPlayerDataSource?.url) {
                        await _betterPlayerController.setupDataSource(
                          BetterPlayerDataSource.network(
                            roomWatching.movieUrl,
                            cacheConfiguration:
                                _buildBetterPlayerConfiguration(),
                          ),
                        );
                        return;
                      }

                      final videoController =
                          _betterPlayerController.videoPlayerController;

                      if (cacheCurrentTime != roomWatching.currentTime) {
                        cacheCurrentTime = roomWatching.currentTime;
                        await videoController?.seekTo(
                          Duration(
                            milliseconds: roomWatching.currentTime.toInt(),
                          ),
                        );
                      }

                      await videoController?.setSpeed(
                        roomWatching.playbackRate.toDouble(),
                      );

                      if (roomWatching.isPlaying) {
                        await _betterPlayerController.play();
                      } else {
                        await _betterPlayerController.pause();
                      }
                    },
                    child: const SizedBox(height: 16),
                  ),
                  BlocSelector<WatchTogetherManagement, TogetherState, String?>(
                    selector: (state) => state.roomWatching?.movieName,
                    builder: (context, movieName) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Watching: ${movieName ?? "Unknown"}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: secondaryTitle,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: _isHostListener,
                    builder: (context, isHost, child) {
                      return isHost
                          ? _buildEpisodeHost(
                              secondaryTitle: secondaryTitle,
                              roomCreation: roomCreation,
                            )
                          : const SizedBox();
                    },
                  ),
                  BlocSelector<
                    WatchTogetherManagement,
                    TogetherState,
                    List<RoomMember>?
                  >(
                    selector: (state) => state.roomWatching?.members,
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.groups,
                              color: VColors.colorIcon,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "In room (${state != null ? state.length : 0})",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  BlocListener<WatchTogetherManagement, TogetherState>(
                    listenWhen: (previous, current) =>
                        current.roomDeleted == true &&
                        previous.roomDeleted != true,
                    listener: (context, state) {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                      if (!roomCreation.isHost) {
                        MethodHelperUtils.showSnackBar(
                          context,
                          "Phòng đã bị host xóa",
                        );
                      }
                    },
                    child: const SizedBox(height: 8),
                  ),

                  // Phần dưới: danh sách người trong phòng, grid 2 cột
                  BlocSelector<
                    WatchTogetherManagement,
                    TogetherState,
                    List<RoomMember>?
                  >(
                    selector: (state) => state.roomWatching?.members,
                    builder: (context, members) {
                      if (members == null || members.isEmpty) {
                        return const SizedBox();
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: members.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 3,
                            ),
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return RoomMemberCard(member: member);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> _showDialog(BuildContext context, String roomId) async {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: VColors.blackBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: VColors.colorIcon, width: 2),
          ),
          title: Text(
            Constants.appName,
            style: const TextStyle(color: VColors.white),
          ),
          content: Text(
            "Are you sure you want to leave the room and delete the room?",
            style: TextStyle(color: VColors.white.withAlpha(200)),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: VColors.colorIcon,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(color: VColors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: VColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await _watchMovieManagement.deleteRoom(roomId);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("L&D", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEpisodeHost({
    required double secondaryTitle,
    required RoomCreation roomCreation,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: EpisodeWidget(
            episodes: roomCreation.combine!.movieWatch.episodes,
            onServerName: (episode) {
              _paginationEpisodeValues!.value = episode.paginationEpisode;
              _episodeListValues!.value = episode.paginationEpisode[1] ?? [];
            },
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _episodeListValues!,
          builder: (context, value, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: EpisodeItem(
                  key: ValueKey(value),
                  episodeList: value,
                  currentEpisode:
                      roomCreation.combine!.movieWatch.currentEpisode,
                  onWatch: (currentEpisode) {
                    roomCreation.combine!.movieWatch.currentEpisode =
                        currentEpisode;
                    _watchMovieManagement.saveMovieHistory(
                      MovieHistoryModel(
                        currentEpisode: MethodHelperUtils.getCurrentEpisode(
                          currentEpisode,
                        ),
                        combineDetailAndWatch: roomCreation.combine!,
                      ),
                    );
                    MovieFunctions.changeEpisode(
                      currentEpisode: currentEpisode,
                      isInPipMode: _isInPipMode,
                      betterPlayerController: _betterPlayerController,
                      isInTogether: true,
                      onNewEpisode: (movieUrl) {
                        _watchMovieManagement.updateRoom(
                          roomId: roomCreation.roomId,
                          movieUrl: movieUrl,
                          isPlaying: false,
                          currentTime: 0,
                        );
                      },
                    );
                  },
                  isInWatch: true,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
          valueListenable: _paginationEpisodeValues!,
          builder: (context, value, child) {
            return Center(
              child: PageWidget(
                key: ValueKey(value),
                pagination: value,
                onChoosePage: (episodeList) {
                  _episodeListValues!.value = episodeList;
                },
                currentPage:
                    roomCreation.combine!.movieWatch.currentListEpisode,
                isInWatch: true,
              ),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEmptyRoom(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: VColors.blackBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VColors.colorIcon.withAlpha(30),
                ),
                child: Icon(
                  Icons.meeting_room_outlined,
                  size: 64,
                  color: VColors.colorIcon,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Room not found",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "This room may have been deleted or no longer exists",
                style: TextStyle(
                  color: Colors.white.withAlpha(150),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: VColors.colorIcon,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BetterPlayerCacheConfiguration _buildBetterPlayerConfiguration() {
    return BetterPlayerCacheConfiguration(
      useCache: true,
      maxCacheSize: 100 * 1024 * 1024,
      maxCacheFileSize: 10 * 1024 * 1024,
    );
  }
}
