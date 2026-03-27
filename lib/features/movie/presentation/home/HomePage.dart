import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
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
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late double _heightScreen;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      context.read<ScalePageBloc>().scalePage(_pageController.page ?? 0.0);
    });
    context.read<HomeBloc>().getHomePageMovie();
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
            child: TitleMovieItem("hihihi"),
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
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, HomeState state) {
                if (state.isLoading &&
                    state.movies.isEmpty &&
                    state.error == null) {
                  return Center(
                    child: CircularProgressIndicator(color: VColors.colorIcon),
                  );
                }
                if (state.error != null &&
                    state.isLoading == false &&
                    state.movies.isEmpty) {
                  return Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VColors.colorIcon,
                      ),
                      onPressed: () {
                        context.read<HomeBloc>().getHomePageMovie();
                      },
                      child: Text("Retry"),
                    ),
                  );
                }
                return PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return BlocBuilder<ScalePageBloc, double>(
                      builder: (BuildContext context, double state) {
                        double diff = state - index;
                        double scale =
                            1 -
                            (diff.abs() * 0.15); //scale theo vị trí khi vuốt
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
                  itemCount: state.movies.length,
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
