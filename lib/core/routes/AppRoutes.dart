import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/presentation/detail_movie/MovieDetailsScreen.dart';
import 'package:movie_app/features/movie/presentation/home/HomePage.dart';
import 'package:movie_app/features/movie/presentation/search/SearchPage.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = GoRouter(
    initialLocation: "/home",
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            appBar: AppBar(
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
        ],
      ),
      GoRoute(
        path: "/movie-details/:slug",
        pageBuilder: (context, state) {
          final slug = state.pathParameters["slug"];
          return CustomTransitionPage(
            child: MovieDetailsScreen(key: ValueKey(slug),movieSlug: slug ?? ""), // cho key khác nhau thì pushReplacement sẽ thay đổi
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
    ],
  );
}
