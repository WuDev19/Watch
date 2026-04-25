import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WatchMovieScreen extends StatefulWidget {
  final String urlMovie;

  const WatchMovieScreen({super.key, required this.urlMovie});

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: false,
        allowedScreenSleep: false,
        fit: BoxFit.contain,
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(
        widget.urlMovie,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          maxCacheSize: 100 * 1024 * 1024,
          maxCacheFileSize: 10 * 1024 * 1024,
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 250));
      _betterPlayerController.enterFullScreen();
      await Future.delayed(const Duration(milliseconds: 250));
      _betterPlayerController.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BetterPlayer(controller: _betterPlayerController));
  }

  bool _checkIsYoutubeVideo(String url) {
    return url.contains("youtube.com");
  }

}
