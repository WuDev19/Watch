import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/core/routes/AppRoutes.dart';
import 'package:movie_app/features/movie/presentation/home/state_management/HomeBloc.dart';
import 'package:movie_app/features/movie/presentation/search/state_management/SearchPageManagement.dart';
import 'package:movie_app/features/movie/presentation/setting/state_managment/SettingScreenManagement.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/state_management/WatchMovieManagement.dart';
import 'package:rive/rive.dart';

import 'features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart';
import 'features/movie/presentation/home/state_management/ScalePageBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configurationDependencies(Environment.dev);
  await RiveNative.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<HomeBloc>()),
        BlocProvider(create: (context) => getIt.get<ScalePageBloc>()),
        BlocProvider(create: (context) => getIt.get<SearchPageManagement>()),
        BlocProvider(create: (context) => getIt.get<MovieDetailManagement>()),
        BlocProvider(create: (context) => getIt.get<WatchMovieManagement>()),
        BlocProvider(create: (context) => getIt.get<SettingScreenManagement>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.routes,
        title: 'Watch',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          splashColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
