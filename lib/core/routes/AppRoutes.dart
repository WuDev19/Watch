import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';
import 'package:movie_app/features/movie/presentation/auth/LoginScreen.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/MovieDetailsScreen.dart';
import 'package:movie_app/features/movie/presentation/home/HomePage.dart';
import 'package:movie_app/features/movie/presentation/search/SearchPage.dart';
import 'package:movie_app/features/movie/presentation/setting/SettingScreen.dart';
import 'package:movie_app/features/movie/presentation/watch_movie/WatchMovieScreen.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = GoRouter(
    initialLocation: "/home",
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            appBar: AppBar(
              actions: navigationShell.currentIndex == 2
                  ? [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.settings, color: Colors.grey),
                      ),
                    ]
                  : null,
              title: const Text(
                "Watch",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: VColors.blackBackground,
            ),
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.black.withAlpha(230),
              indicatorColor: Colors.transparent,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(index);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home, size: 50),
                  label: "",
                  selectedIcon: const Icon(
                    Icons.home,
                    size: 50,
                    color: VColors.colorIcon,
                  ),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.video_collection, size: 50),
                  label: "",
                  selectedIcon: const Icon(
                    Icons.video_collection,
                    size: 50,
                    color: VColors.colorIcon,
                  ),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person, size: 50),
                  label: "",
                  selectedIcon: const Icon(
                    Icons.person,
                    size: 50,
                    color: VColors.colorIcon,
                  ),
                ),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/home",
                builder: (context, state) {
                  return const HomePage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/search",
                builder: (context, state) {
                  return const SearchPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/setting",
                builder: (context, state) {
                  return const SettingScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/movie-details/:slug",
        pageBuilder: (context, state) {
          final slug = state.pathParameters["slug"];
          return CustomTransitionPage(
            child: MovieDetailsScreen(
              key: ValueKey(slug),
              movieSlug: slug ?? "",
            ),
            // cho key khác nhau thì pushReplacement sẽ thay đổi
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: "/watch-movie",
        pageBuilder: (context, state) {
          final data = state.extra;
          CombineDetailAndWatch? combine;
          if (data is CombineDetailAndWatch) {
            combine = data;
          }
          return CustomTransitionPage(
            child: WatchMovieScreen(combineDetailAndWatch: combine),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  );
                  return ScaleTransition(
                    scale: curved,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(20),
                      ),
                      child: child,
                    ),
                  );
                },
          );
        },
      ),
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const LoginScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
    ],
  );
}
