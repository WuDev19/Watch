import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/models/EpisodeList.dart';

class MovieFunctions {
  MovieFunctions._();

  static void enterPipMode({
    required BetterPlayerController betterPlayerController,
    required GlobalKey betterPlayerKey,
  }) async {
    bool isSupported = await betterPlayerController
        .isPictureInPictureSupported();
    if (isSupported) {
      if (betterPlayerController.isPlaying() == true) {
        if (betterPlayerController.isFullScreen) {
          betterPlayerController.exitFullScreen();
          await Future.delayed(const Duration(milliseconds: 400));
        }
        await betterPlayerController.enablePictureInPicture(betterPlayerKey);
      }
    }
  }

  static Future<void> changeEpisode({
    required EpisodeList currentEpisode,
    required bool isInPipMode,
    required BetterPlayerController betterPlayerController,
  }) async {
    if (isInPipMode) {
      await betterPlayerController.disablePictureInPicture();
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); //đợi một chút sau khi đóng pip
    }
    await betterPlayerController.pause(); //dừng video cũ để tránh lỗi
    BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
      currentEpisode.linkM3U8,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
      ),
    );
    await betterPlayerController.setupDataSource(dataSource);
    betterPlayerController.play();
  }
}
