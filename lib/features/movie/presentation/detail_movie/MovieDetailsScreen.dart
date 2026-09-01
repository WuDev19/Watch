import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/domain/models/EpisodeList.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/MovieHistoryModel.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatch.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/ErrorHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/LoadingHandleWidget.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/MovieDetailState.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/ActorItem.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/AddRoomMemberDialog.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/ChooseEpisodeRoomDialog.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/ChooseRoomOptionsSheet.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/EpisodeItem.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/EpisodeWidget.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/ExpandScrollText.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/GenreItem.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/PageWidget.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/RelatedMovieItem.dart';
import 'package:movie_app/utils/MethodHelperUtils.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/RoomCreation.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String _movieSlug;

  const MovieDetailsScreen({super.key, required String movieSlug})
    : _movieSlug = movieSlug;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late double _screenHeight;
  late double _screenWidth;
  late ScrollController _relatedMovieController;
  late MovieDetailManagement _movieDetailManagement;
  late ValueNotifier<Map<int, List<EpisodeList>>> _paginationEpisodeValues;
  late ValueNotifier<List<EpisodeList>> _episodeListValues;
  late ValueNotifier<bool> _addToFavoriteValues;
  String? _categorySlug;
  bool _isLoading = false;
  bool _isFavorite = false;
  Map<String, dynamic> dynamicCategory = {
    "sort_field": "year",
    "sort_type": "desc",
  };

  @override
  void initState() {
    super.initState();
    _relatedMovieController = ScrollController();
    _relatedMovieController.addListener(_onLoadMore);
    _paginationEpisodeValues = ValueNotifier({});
    _episodeListValues = ValueNotifier([]);
    _addToFavoriteValues = ValueNotifier(false);
    _movieDetailManagement = context.read<MovieDetailManagement>();
    _movieDetailManagement.getMovieDetailsInfo(widget._movieSlug);
    _movieDetailManagement.getMovieActors(widget._movieSlug);
    _movieDetailManagement.checkFavoriteMovie(widget._movieSlug).then((value) {
      _addToFavoriteValues.value = value;
      _isFavorite = value;
    });
    //thêm cái call từ local xem có trong local chưa
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = Constants.getHeightScreen(context);
    _screenWidth = Constants.getWidthScreen(context);
  }

  @override
  void dispose() {
    _relatedMovieController.removeListener(_onLoadMore);
    _relatedMovieController.dispose();
    _episodeListValues.dispose();
    _paginationEpisodeValues.dispose();
    super.dispose();
  }

  void _onLoadMore() {
    if (_relatedMovieController.offset >=
        _relatedMovieController.position.maxScrollExtent *
            Constants.rateScroll) {
      if (_isLoading) return;
      _isLoading = true;
      if (_categorySlug != null) {
        _movieDetailManagement.relatedMovie(
          _categorySlug!,
          widget._movieSlug,
          false,
          dynamicCategory,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightImage = 0.4 * _screenHeight;
    final marginContent = 0.65 * _screenHeight / _screenHeight;
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    final double itemWidth = Constants.getImageWidth(context);
    final double itemHeight = Constants.getImageHeight(context);
    return Scaffold(
      body: // detail movie
      BlocSelector<MovieDetailManagement, MovieDetailState, (MovieDetails?, bool, String?)>(
        selector: (state) => (
          state.movieDetails,
          state.isLoadingMovieDetails,
          state.errorMovieDetails,
        ),
        builder: (context, state) {
          if (state.$2 == true && state.$3 == null && state.$1 == null) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: VColors.blackBackground,
              child: const Center(
                child: CircularProgressIndicator(color: VColors.colorIcon),
              ),
            );
          }
          if (state.$3 != null) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: VColors.blackBackground,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    _movieDetailManagement.getMovieDetailsInfo(
                      widget._movieSlug,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VColors.colorIcon,
                  ),
                  child: Text("Retry", style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          }
          if (state.$1 == null) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: VColors.blackBackground,
              child: const Center(
                child: Text(
                  "Oops, some thing went wrong!",
                  style: TextStyle(color: VColors.white),
                ),
              ),
            );
          }
          final movieDetail = state.$1!;
          _paginationEpisodeValues.value =
              movieDetail.episodes.first.paginationEpisode; //danh sách server
          _episodeListValues.value =
              movieDetail.episodes.first.paginationEpisode[1]!;
          final genres = movieDetail.category
              .map((e) => GenreItem(genre: e.category))
              .toList();
          movieDetail.category.shuffle();
          _categorySlug = movieDetail
              .category[0]
              .categorySlug; //lấy ngẫu nhiên một category để call related movie
          _movieDetailManagement.relatedMovie(
            _categorySlug!,
            widget._movieSlug,
            true,
            dynamicCategory,
          );
          return Stack(
            children: [
              Image.network(
                movieDetail.posterUrl,
                height: heightImage,
                width: _screenWidth,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: _screenWidth,
                    height: heightImage,
                    color: VColors.blackBackground,
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 0.25 * heightImage),
                      child: const CircularProgressIndicator(
                        color: VColors.colorIcon,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, url, error) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          VColors.greySearch.withValues(alpha: 0.6),
                          VColors.greySearch.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.white.withValues(alpha: 0.25),
                      size: 36,
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 0.4 * heightImage),
                alignment: AlignmentGeometry.topCenter,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final success = await _openYoutube(
                          movieDetail.trailerUrl,
                        );
                        if (!context.mounted) return;
                        if (!success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Can not open the trailer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              padding: const EdgeInsets.all(20),
                              backgroundColor: VColors.colorIcon,
                              behavior: SnackBarBehavior.floating,
                              //phải có behavior này thì mới custom margin được
                              duration: const Duration(seconds: 2),
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      label: const Text(
                        "Trailer",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.play_arrow,
                        color: VColors.colorIcon,
                      ),
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(VColors.colorIcon),
                        backgroundColor: WidgetStatePropertyAll(
                          VColors.greySearch,
                        ),
                        elevation: WidgetStatePropertyAll(10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        final currentEpisode = movieDetail
                            .episodes
                            .first
                            .paginationEpisode[1]
                            ?.first;
                        final currentListEpisodes =
                            movieDetail.episodes.first.paginationEpisode[1]!;
                        final movieWatch = MovieWatch(
                          movieName: movieDetail.name,
                          currentEpisode: currentEpisode!,
                          episodes: movieDetail.episodes,
                          currentListEpisode: currentListEpisodes,
                        );
                        final movieCombine = CombineDetailAndWatch(
                          movieWatch: movieWatch,
                          movieSlug: movieDetail.slug,
                          moviePoster: movieDetail.posterUrl,
                          total: movieDetail.total,
                        );
                        _movieDetailManagement.saveMovieHistory(
                          MovieHistoryModel(
                            currentEpisode: 1,
                            combineDetailAndWatch: movieCombine,
                          ),
                        );
                        context.push("/watch-movie", extra: movieCombine);
                      },
                      label: const Text(
                        "Watch movie",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.play_arrow,
                        color: VColors.colorIcon,
                      ),
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(VColors.colorIcon),
                        backgroundColor: WidgetStatePropertyAll(
                          VColors.greySearch,
                        ),
                        elevation: WidgetStatePropertyAll(10),
                      ),
                    ),
                    BlocListener<MovieDetailManagement, MovieDetailState>(
                      listenWhen: (previous, current) =>
                          previous.createRoomState != current.createRoomState,
                      listener: (context, state) {
                        if (state.createRoomState.isLoading) {
                          MethodHelperUtils.showLoadingDialog(context);
                        } else if (state.createRoomState.error != null) {
                          Navigator.of(context, rootNavigator: true).pop();
                          MethodHelperUtils.showSnackBar(
                            context,
                            "Create room unsuccessfully",
                          );
                        } else {
                          Navigator.of(context, rootNavigator: true).pop();
                          context.push(
                            "/watch-together",
                            extra: state.createRoomState.roomCreation,
                          );
                        }
                      },
                      child: const SizedBox(width: 10),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        ChooseRoomOptionsSheet.show(
                          context,
                          onSelected: (RoomType option) async {
                            Navigator.of(context).pop();
                            if (!context.mounted) return;
                            switch (option) {
                              case RoomType.create:
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => Provider.value(
                                    value: _movieDetailManagement,
                                    child: AddRoomMemberDialog(
                                      onNext: (members) {
                                        if (members.isEmpty) {
                                          return;
                                        }
                                        Navigator.of(
                                          dialogContext,
                                        ).pop(); // đóng dialog chọn thành viên
                                        if (!context.mounted) return;
                                        ChooseEpisodeRoomDialog.show(
                                          context,
                                          movieDetail: movieDetail,
                                          onConfirm:
                                              (
                                                selectedEpisode,
                                                currentListEpisode,
                                              ) {
                                                final movieWatch = MovieWatch(
                                                  movieName: movieDetail.name,
                                                  currentEpisode:
                                                      selectedEpisode,
                                                  episodes:
                                                      movieDetail.episodes,
                                                  currentListEpisode:
                                                      currentListEpisode,
                                                );
                                                final movieCombine =
                                                    CombineDetailAndWatch(
                                                      movieWatch: movieWatch,
                                                      movieSlug:
                                                          movieDetail.slug,
                                                      moviePoster:
                                                          movieDetail.posterUrl,
                                                      total: movieDetail.total,
                                                    );
                                                final roomCreation = RoomCreation(
                                                  combine: movieCombine,
                                                  reserveMembers: members,
                                                  isHost: true,
                                                  roomId:
                                                      MethodHelperUtils.randomString(
                                                        10,
                                                      ),
                                                );
                                                _movieDetailManagement
                                                    .createRoom(roomCreation);
                                              },
                                        );
                                      },
                                    ), //bọc vào cái này để có thể lấy context, ví show dialog tạo context mới dưới navigator
                                  ),
                                );
                                break;
                              case RoomType.join:
                                showJoinDialog(context);
                                break;
                            }
                          },
                        );
                      },
                      label: const Text(
                        "Watch together",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.groups, color: VColors.colorIcon),
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(VColors.colorIcon),
                        backgroundColor: WidgetStatePropertyAll(
                          VColors.greySearch,
                        ),
                        elevation: WidgetStatePropertyAll(10),
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                maxChildSize: 0.9,
                initialChildSize: marginContent,
                minChildSize: marginContent,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadiusGeometry.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildNameQualityCountry(movieDetail),
                          const SizedBox(height: 10),
                          _buildTimeStarView(movieDetail),
                          const SizedBox(height: 10),
                          _buildReleaseDateGenre(
                            movieDetail,
                            secondaryTitle,
                            genres,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Synopsis",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: secondaryTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ExpandScrollText(movieSynopsis: movieDetail.content),
                          const SizedBox(height: 10),
                          Text(
                            "Episodes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: secondaryTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          EpisodeWidget(
                            episodes: movieDetail.episodes,
                            onServerName: (episode) {
                              _paginationEpisodeValues.value =
                                  episode.paginationEpisode;
                              _episodeListValues.value =
                                  episode.paginationEpisode[1] ?? [];
                            },
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
                                child: EpisodeItem(
                                  key: ValueKey(value),
                                  episodeList: value,
                                  currentEpisode: null,
                                  onWatch: (currentEpisode) {
                                    final movieWatch = MovieWatch(
                                      movieName: movieDetail.name,
                                      currentEpisode: currentEpisode,
                                      episodes: movieDetail.episodes,
                                      currentListEpisode: value,
                                    );
                                    final movieCombine = CombineDetailAndWatch(
                                      movieWatch: movieWatch,
                                      movieSlug: movieDetail.slug,
                                      moviePoster: movieDetail.posterUrl,
                                      total: movieDetail.total,
                                    );
                                    _movieDetailManagement.saveMovieHistory(
                                      MovieHistoryModel(
                                        currentEpisode:
                                            MethodHelperUtils.getCurrentEpisode(
                                              currentEpisode,
                                            ),
                                        combineDetailAndWatch: movieCombine,
                                      ),
                                    );
                                    context.push(
                                      "/watch-movie",
                                      extra: movieCombine,
                                    );
                                  },
                                  isInWatch: false,
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
                                  currentPage: null,
                                  isInWatch: false,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Actors",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: secondaryTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: itemHeight,
                            child: //movie actors
                                BlocSelector<
                                  MovieDetailManagement,
                                  MovieDetailState,
                                  (List<MovieActors>, bool, String?)
                                >(
                                  selector: (MovieDetailState state) => (
                                    state.movieActors,
                                    state.isLoadingMovieActors,
                                    state.errorMovieActors,
                                  ),
                                  builder: (context, state) {
                                    if (state.$2) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: VColors.colorIcon,
                                        ),
                                      );
                                    }
                                    if (state.$3 != null) {
                                      return Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: VColors.colorIcon,
                                          ),
                                          onPressed: () {
                                            _movieDetailManagement
                                                .getMovieActors(
                                                  widget._movieSlug,
                                                );
                                          },
                                          child: Text(
                                            "Retry",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (state.$1.isEmpty) {
                                      return Center(
                                        child: Text(
                                          Constants.nothing,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      itemExtent: itemWidth,
                                      itemBuilder: (context, index) {
                                        final actor = state.$1[index];
                                        return Container(
                                          margin: const EdgeInsets.all(8),
                                          child: ActorItem(
                                            nameActor: actor.name,
                                            originalNameActor:
                                                actor.originalName,
                                            profilePicture:
                                                actor.profilePicture,
                                          ),
                                        );
                                      },
                                      itemCount: state.$1.length,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  },
                                ),
                          ),
                          Text(
                            "Related movies",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: secondaryTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: itemHeight - 40,
                            // do ko lấy thêm chữ nên trừ đi khoảng 40
                            child:
                                BlocSelector<
                                  MovieDetailManagement,
                                  MovieDetailState,
                                  (List<SearchMovieDisplay>, bool, String?)
                                >(
                                  selector: (state) => (
                                    state.movieRelated,
                                    state.isLoadingMovieRelated,
                                    state.errorMovieRelated,
                                  ),
                                  builder: (context, state) {
                                    _isLoading = false;
                                    if (state.$2 && state.$1.isEmpty) {
                                      return const LoadingHandleWidget();
                                    }
                                    if (state.$3 != null) {
                                      return ErrorHandleWidget(
                                        onTap: () => _movieDetailManagement
                                            .getMovieDetailsInfo(
                                              widget._movieSlug,
                                            ),
                                      );
                                    }
                                    return ListView.builder(
                                      key: PageStorageKey(
                                        "related_movie:${movieDetail.slug}",
                                      ),
                                      controller: _relatedMovieController,
                                      itemExtent: itemWidth,
                                      itemBuilder: (context, index) {
                                        final movie = state.$1[index];
                                        return InkWell(
                                          onTap: () => context.pushReplacement(
                                            "/movie-details/${movie.movieSlug}",
                                          ),
                                          child: RelatedMovieItem(
                                            moviePoster: movie.moviePoster,
                                          ),
                                        );
                                      },
                                      itemCount: state.$1.length,
                                      scrollDirection: Axis.horizontal,
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeStarView(MovieDetails movieDetail) {
    return Wrap(
      children: [
        const Icon(Icons.timer, color: VColors.colorIcon),
        const SizedBox(width: 5),
        Text(movieDetail.time, style: TextStyle(color: Colors.white)),
        const SizedBox(width: 20),
        const Icon(Icons.star, color: VColors.colorIcon),
        Text(
          movieDetail.movieStar.toStringAsFixed(1),
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 20),
        Text(
          "${movieDetail.episodeTotal} episodes",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 20),
        Text(
          movieDetail.view >= 2
              ? "${movieDetail.view} views"
              : "${movieDetail.view} view",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildNameQualityCountry(MovieDetails movieDetail) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          movieDetail.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: Constants.calculateFontSize(context, 1.2),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            color: VColors.greySearch,
          ),
          padding: const EdgeInsets.all(6),
          child: Text(
            movieDetail.quality,
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Text(movieDetail.country, style: TextStyle(color: Colors.white)),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            if (_isFavorite) {
              _movieDetailManagement.deleteFavoriteMovie(movieDetail.slug);
            } else {
              _movieDetailManagement.saveFavoriteMovie(
                FavoriteMovieModel(
                  movieName: movieDetail.name,
                  movieSlug: movieDetail.slug,
                  thumbUrl: movieDetail.thumbUrl,
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
      ],
    );
  }

  Widget _buildReleaseDateGenre(
    MovieDetails movieDetail,
    double secondaryTitle,
    List<GenreItem> genres,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Release date",
              style: TextStyle(
                color: Colors.white,
                fontSize: secondaryTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              movieDetail.releaseDate,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Genre",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: secondaryTitle,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(spacing: 5, runSpacing: 5, children: genres),
            ],
          ),
        ),
      ],
    );
  }

  Future<bool> _openYoutube(String url) async {
    final uri = Uri.parse(url);
    bool success = false;
    try {
      success = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!success) {
        success = await launchUrl(uri);
      }
    } catch (e) {
      success = false;
    }
    return success;
  }

  void showJoinDialog(BuildContext context) {
    final TextEditingController roomCodeController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: VColors.blackBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: VColors.colorIcon, width: 2),
        ),
        icon: Icon(Icons.movie_creation_outlined, color: VColors.colorIcon),
        title: Text("Join room", style: TextStyle(color: VColors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter the room code to join",
              style: TextStyle(color: VColors.white.withAlpha(155)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: roomCodeController,
              autofocus: true,
              style: TextStyle(color: VColors.white),
              cursorColor: VColors.colorIcon,
              decoration: InputDecoration(
                hintText: "Room code",
                hintStyle: TextStyle(color: VColors.white.withAlpha(100)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: VColors.white.withAlpha(80)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: VColors.colorIcon,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ],
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
            child: Text("Cancel", style: TextStyle(color: VColors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final code = roomCodeController.text.trim();
              if (code.isEmpty) return;
              Navigator.of(dialogContext).pop();
              context.push(
                "/watch-together",
                extra: RoomCreation(isHost: false, roomId: code),
              );
            },
            child: const Text(
              "Join",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
