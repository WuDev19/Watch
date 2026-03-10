import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state/MovieDetailState.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/widgets/GenreItem.dart';
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
  late MovieDetailManagement _movieDetailManagement;

  @override
  void initState() {
    super.initState();
    print(widget._movieSlug);
    _scrollController = ScrollController();
    _movieDetailManagement = context.read<MovieDetailManagement>();
    _movieDetailManagement.getMovieDetailsInfo(widget._movieSlug);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = Constants.getHeightScreen(context);
    _screenWidth = Constants.getWidthScreen(context);
    final heightImage = 0.4 * _screenHeight;
    final marginContent = 0.65 * _screenHeight / _screenHeight;
    final secondaryTitle = Constants.calculateFontSize(context, 1.1);
    return Scaffold(
      body: BlocBuilder<MovieDetailManagement, MovieDetailState>(
        builder: (BuildContext context, MovieDetailState state) {
          if (state.isLoading == true &&
              state.error == null &&
              state.movieDetails == null) {
            return Center(child: const CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  _movieDetailManagement.getMovieDetailsInfo(widget._movieSlug);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: Text("Retry", style: TextStyle(color: Colors.white)),
              ),
            );
          }
          final movieDetail = state.movieDetails!;
          final genres = movieDetail.category
              .map((e) => GenreItem(genre: e.category))
              .toList();
          return Stack(
            children: [
              Image.network(
                Constants.baseImageUrl + state.movieDetails!.thumbUrl,
                height: heightImage,
                fit: BoxFit.contain,
              ),
              DraggableScrollableSheet(
                maxChildSize: 0.9,
                initialChildSize: marginContent,
                minChildSize: marginContent,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: VColors.blackBackground,
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
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    movieDetail.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constants.calculateFontSize(
                                        context,
                                        1.2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadiusGeometry.all(
                                        Radius.circular(10),
                                      ),
                                      color: VColors.greySearch,
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      movieDetail.quality,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    movieDetail.country,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: VColors.colorIcon,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    movieDetail.time,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.star,
                                    color: VColors.colorIcon,
                                  ),
                                  Text(
                                    movieDetail.movieStar.toStringAsFixed(1),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: genres,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                              Text(
                                movieDetail.content,
                                style: TextStyle(color: Colors.white),
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
                                height: 150,
                                child: ListView.builder(
                                  itemBuilder: (context, index) => AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: Image.asset("assets/images/try.png"),
                                  ),
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
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
                                height: 150,
                                child: ListView.builder(
                                  itemBuilder: (context, index) => AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: Image.asset("assets/images/try.png"),
                                  ),
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
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
}
