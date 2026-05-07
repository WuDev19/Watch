import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';
import 'package:movie_app/features/movie/presentation/setting/state/SettingState.dart';
import 'package:movie_app/features/movie/presentation/setting/state_managment/SettingScreenManagement.dart';
import 'package:movie_app/features/movie/presentation/setting/widgets/FavoriteMovieWidget.dart';
import 'package:movie_app/utils/constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final double _secondaryTitle;
  late final double _screenWidth;
  late final double _imageHeight;
  late final double _imageWidth;
  late final SettingScreenManagement _settingScreenManagement;

  @override
  void initState() {
    super.initState();
    _settingScreenManagement = context.read<SettingScreenManagement>();
    _settingScreenManagement.getMyFavoriteMovie();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _secondaryTitle = Constants.calculateFontSize(context, 1.1);
    _screenWidth = Constants.getWidthScreen(context);
    _imageHeight = Constants.getImageHeight(context);
    _imageWidth = Constants.getImageWidth(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VColors.blackBackground,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              Constants.favoriteMovie,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _secondaryTitle,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: _imageHeight,
              child:
                  BlocSelector<
                    SettingScreenManagement,
                    SettingState,
                    (List<FavoriteMovieModel>, bool, String?)
                  >(
                    selector: (state) => (
                      state.favoriteMovies,
                      state.favoriteLoading,
                      state.favoriteError,
                    ),
                    builder: (context, state) {
                      if (state.$3 != null) {
                        return Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: VColors.colorIcon,
                            ),
                            onPressed: () {
                              _settingScreenManagement.getMyFavoriteMovie();
                            },
                            child: Text(
                              Constants.retry,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      if (state.$2) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: VColors.colorIcon,
                          ),
                        );
                      }
                      final favoriteMovies = state.$1;
                      return ListView.builder(
                        itemExtent: _imageWidth,
                        itemBuilder: (context, index) {
                          final favorMovie = favoriteMovies[index];
                          return FavoriteMovieWidget(
                            favoriteMovie: FavoriteMovieModel(
                              movieName: favorMovie.movieName,
                              movieSlug: favorMovie.movieSlug,
                              thumbUrl: favorMovie.thumbUrl,
                            ),
                          );
                        },
                        itemCount: favoriteMovies.length,
                        scrollDirection: Axis.horizontal,
                      );
                    },
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              Constants.watchingMovie,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _secondaryTitle,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: _imageHeight,
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  height: 100,
                  width: 100,
                  color: Colors.cyan,
                  margin: const EdgeInsets.all(10),
                ),
                itemCount: 20,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Constants.watchedMovie,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _secondaryTitle,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: _imageHeight,
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  height: 100,
                  width: 100,
                  color: Colors.cyan,
                  margin: const EdgeInsets.all(10),
                ),
                itemCount: 20,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
