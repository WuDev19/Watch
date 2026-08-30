import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/ErrorHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/LoadingHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/watch/function/MovieFunctions.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/watch/widgets/MoviePlayer.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state/GetCommentState.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state/SelfState.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state/WatchMovieState.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state_management/WatchMovieManagement.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/widgets/CommentItem.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/widgets/WriteComment.dart';
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
        }
      });
      print(
        "url: ${widget.combineDetailAndWatch!.movieWatch.currentEpisode.linkM3U8}",
      );
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
      });

      _watchMovieManagement
          .checkFavoriteMovie(widget.combineDetailAndWatch!.movieSlug)
          .then((value) {
            _addToFavoriteValues.value = value;
            _isFavorite = value;
          });
      _watchMovieManagement.getMyProfile();
      _watchMovieManagement.getComments(
        widget.combineDetailAndWatch!.movieSlug,
      );
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
                  MoviePlayer(
                    betterPlayerController: _betterPlayerController!,
                    betterPlayerKey: _betterPlayerKey,
                    enterPipMode: () => MovieFunctions.enterPipMode(
                      betterPlayerController: _betterPlayerController!,
                      betterPlayerKey: _betterPlayerKey,
                    ),
                  ),
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
                              MovieFunctions.changeEpisode(
                                currentEpisode: currentEpisode,
                                isInPipMode: _isInPipMode,
                                betterPlayerController:
                                    _betterPlayerController!,
                                isInTogether: false,
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
                  BlocListener<WatchMovieManagement, WatchMovieState>(
                    listenWhen: (previous, current) =>
                        previous.actionCommentState !=
                        current.actionCommentState,
                    listener: (context, state) {
                      if (state.actionCommentState.isLoading) {
                        MethodHelperUtils.showLoadingDialog(context);
                      } else if (state.actionCommentState.error != null) {
                        Navigator.of(context, rootNavigator: true).pop();
                        MethodHelperUtils.showSnackBar(
                          context,
                          state.actionCommentState.error!,
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true).pop();
                        MethodHelperUtils.showSnackBar(
                          context,
                          state.actionCommentState.isPost
                              ? "Post comment successfully"
                              : "Delete comment successfully",
                        );
                        _watchMovieManagement.getComments(combine.movieSlug);
                      }
                    },
                    child: const SizedBox(height: 16),
                  ),
                  _buildCommentSection(combine, secondaryTitle),
                  const SizedBox(height: 24),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
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
                    thumbUrl: combine.moviePoster,
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

  Widget _buildCommentSection(
    CombineDetailAndWatch combine,
    double secondaryTitle,
  ) {
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
          BlocSelector<WatchMovieManagement, WatchMovieState, SelfState>(
            selector: (state) => state.selfState,
            builder: (context, state) {
              return WriteComment(
                controller: _commentController,
                onSend: (comment) {
                  if (comment.isEmpty) return;
                  _watchMovieManagement.postComment(
                    state.avt,
                    state.name!,
                    comment,
                    combine.movieSlug,
                  );
                  _commentController.clear();
                },
                avt: state.avt,
              );
            },
          ),
          const SizedBox(height: 16),
          BlocSelector<WatchMovieManagement, WatchMovieState, GetCommentState>(
            selector: (state) => state.getCommentState,
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingHandleWidget();
              }
              if (state.error != null) {
                return ErrorHandleWidget(
                  onTap: () =>
                      _watchMovieManagement.getComments(combine.movieSlug),
                );
              }
              final commentTotal = state.commentTotal;
              final comments = commentTotal?.comments ?? [];
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return CommentItem(
                    commentDisplay: comment,
                    onDelete: (commentId) {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          backgroundColor: VColors.blackBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: VColors.colorIcon,
                              width: 2,
                            ),
                          ),
                          title: Text(
                            "Delete comment",
                            style: TextStyle(color: VColors.white),
                          ),
                          content: Text(
                            "Are you sure you want to delete this comment?",
                            style: TextStyle(
                              color: VColors.white.withAlpha(155),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: VColors.colorIcon,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              child: Text(
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
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                _watchMovieManagement.deleteComment(commentId);
                                comments.remove(comment);
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
