import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/MovieActors.dart';
import 'package:movie_app/features/movie/domain/models/MovieDetails.dart';
import 'package:movie_app/features/movie/domain/models/SearchMovieDisplay.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/MovieDetailState.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/ActorItem.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/ExpandScrollText.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/GenreItem.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/RelatedMovieItem.dart';
import 'package:movie_app/utils/constants.dart';

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
  late ScrollController _scrollController;
  late ScrollController _relatedMovieController;
  late MovieDetailManagement _movieDetailManagement;
  String? _categorySlug;
  bool _isLoading = false;
  Map<String, dynamic> dynamicCategory = {
    "sort_field": "year",
    "sort_type": "desc",
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _relatedMovieController = ScrollController();
    _relatedMovieController.addListener(_onLoadMore);
    _movieDetailManagement = context.read<MovieDetailManagement>();
    _movieDetailManagement.getMovieDetailsInfo(widget._movieSlug);
    _movieDetailManagement.getMovieActors(widget._movieSlug);
  }

  @override
  void dispose() {
    super.dispose();
    _relatedMovieController.removeListener(_onLoadMore);
    _scrollController.dispose();
    _relatedMovieController.dispose();
  }

  void _onLoadMore() {
    if (_relatedMovieController.offset >=
        _relatedMovieController.position.maxScrollExtent * 0.9) {
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
    _screenHeight = Constants.getHeightScreen(context);
    _screenWidth = Constants.getWidthScreen(context);
    final heightImage = 0.4 * _screenHeight;
    final marginContent = 0.65 * _screenHeight / _screenHeight;
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    final double itemWidth = (_screenWidth - 32) / 3;
    final double itemHeight = itemWidth * 1.5 + 40;
    return Scaffold(
      body: // detail movie
          BlocSelector<
            MovieDetailManagement,
            MovieDetailState,
            (MovieDetails?, bool, String?)
          >(
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
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _movieDetailManagement.getMovieDetailsInfo(
                        widget._movieSlug,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    child: Text("Retry", style: TextStyle(color: Colors.white)),
                  ),
                );
              }
              final movieDetail = state.$1!;
              final genres = movieDetail.category
                  .map((e) => GenreItem(genre: e.category))
                  .toList();
              movieDetail.category.shuffle();
              _categorySlug = movieDetail.category[0].categorySlug;
              _movieDetailManagement.relatedMovie(
                _categorySlug!,
                widget._movieSlug,
                true,
                dynamicCategory,
              );
              return Stack(
                children: [
                  Image.network(
                    Constants.baseImageUrl + movieDetail.posterUrl,
                    height: heightImage,
                    width: _screenWidth,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      final value =
                          loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!;
                      return Container(
                        width: _screenWidth,
                        height: heightImage,
                        color: VColors.blackBackground,
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 0.25 * heightImage),
                          child: CircularProgressIndicator(
                            value: value,
                            color: VColors.colorIcon,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.4 * heightImage),
                    alignment: AlignmentGeometry.topCenter,
                    child: Wrap(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
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
                            overlayColor: WidgetStatePropertyAll(
                              VColors.colorIcon,
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              VColors.greySearch,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {},
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
                            overlayColor: WidgetStatePropertyAll(
                              VColors.colorIcon,
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              VColors.greySearch,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DraggableScrollableSheet(
                    maxChildSize: 0.9,
                    initialChildSize: marginContent,
                    minChildSize: marginContent,
                    builder: (BuildContext context, ScrollController scrollController) {
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
                              ExpandScrollText(
                                movieSynopsis: movieDetail.content,
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
                                                backgroundColor:
                                                    VColors.colorIcon,
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
                                              "Nothing to show",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
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
                                        if (state.$2) {
                                          return Center(
                                            child:
                                                const CircularProgressIndicator(
                                                  color: VColors.colorIcon,
                                                ),
                                          );
                                        }
                                        if (state.$3 != null) {
                                          return Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    VColors.colorIcon,
                                              ),
                                              onPressed: () {
                                                _movieDetailManagement
                                                    .getMovieDetailsInfo(
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
                                        print("shuffle- ${state.$1}");
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
    return Row(
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
        const Spacer(),
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
}
