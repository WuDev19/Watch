import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/colors/VColors.dart';

class MoviePlayer extends StatelessWidget {
  final BetterPlayerController betterPlayerController;
  final GlobalKey betterPlayerKey;
  final void Function() enterPipMode;

  const MoviePlayer({
    super.key,
    required this.betterPlayerController,
    required this.betterPlayerKey,
    required this.enterPipMode,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BetterPlayer(
              key: betterPlayerKey,
              controller: betterPlayerController,
            ),
            Positioned(
              left: 10,
              child: GestureDetector(
                onTap: () => enterPipMode(),
                child: Icon(Icons.picture_in_picture, color: VColors.colorIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
