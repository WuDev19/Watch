import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/MovieDisplay.dart';
import 'package:movie_app/features/movie/domain/models/MovieWatched.dart';
import 'package:movie_app/features/movie/presentation/common_widgets/EmptyDataWidget.dart';
import 'package:movie_app/features/movie/presentation/home/state_management/HomeBloc.dart';
import 'package:movie_app/features/movie/presentation/home/state/HomeState.dart';
import 'package:movie_app/features/movie/presentation/home/state_management/ScalePageBloc.dart';
import 'package:movie_app/features/movie/presentation/home/widgets/TitleMovieItem.dart';
import 'package:movie_app/features/movie/presentation/home/widgets/TrendingMovieItem.dart';
import 'package:movie_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
  late PageController _pageController;
  late double _heightScreen;
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      context.read<ScalePageBloc>().scalePage(_pageController.page ?? 0.0);
    });
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.getHomePageMovie();
    _homeBloc.getLastMovieWatched();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _heightScreen = Constants.getHeightScreen(context);
    return Container(
      color: VColors.blackBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _heightScreen * 0.3,
            child:
                BlocSelector<
                  HomeBloc,
                  HomeState,
                  (MovieWatched?, bool, String?)
                >(
                  selector: (state) => (
                    state.movieWatched,
                    state.isLoadingMovieWatched,
                    state.errorMovieWatched,
                  ),
                  builder: (context, state) {
                    if (state.$2) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: VColors.colorIcon,
                        ),
                      );
                    }
                    if (state.$3 != null) {
                      return Center(
                        child: Text(
                          "Has error ${state.$3}",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    if (state.$1 == null) {
                      print("nulllll");
                      return const EmptyDataWidget();
                    }
                    return TitleMovieItem(state.$1!);
                  },
                ),
          ),
          //continue
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department_sharp,
                  color: VColors.colorIcon,
                ),
                SizedBox(width: 10),
                Text(
                  "New movies",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child:
                BlocSelector<
                  HomeBloc,
                  HomeState,
                  (List<MovieDisplay>, bool, String?)
                >(
                  selector: (state) =>
                      (state.movies, state.isLoading, state.error),
                  builder: (context, state) {
                    if (state.$2 && state.$1.isEmpty && state.$3 == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: VColors.colorIcon,
                        ),
                      );
                    }
                    if (state.$3 != null &&
                        state.$2 == false &&
                        state.$1.isEmpty) {
                      return Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VColors.colorIcon,
                          ),
                          onPressed: () {
                            context.read<HomeBloc>().getHomePageMovie();
                          },
                          child: Text(
                            "Retry",
                            style: TextStyle(color: VColors.white),
                          ),
                        ),
                      );
                    }
                    return PageView.builder(
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        final movie = state.$1[index];
                        return BlocBuilder<ScalePageBloc, double>(
                          builder: (BuildContext context, double state) {
                            double diff = state - index;
                            double scale =
                                1 -
                                (diff.abs() *
                                    0.15); //scale theo vị trí khi vuốt
                            scale = max(0.8, scale);
                            return AnimatedBuilder(
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: TrendingMovieItem(
                                    moviePoster: movie.moviePoster,
                                    movieName: movie.movieName,
                                    movieSlug: movie.movieSlug,
                                    movieStar: movie.movieStar,
                                    onDetail: (slug) {
                                      context.push("/movie-details/$slug");
                                    },
                                  ),
                                );
                              },
                              animation: _pageController,
                            );
                          },
                        );
                      },
                      itemCount: state.$1.length,
                      pageSnapping: true,
                    );
                  },
                ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
