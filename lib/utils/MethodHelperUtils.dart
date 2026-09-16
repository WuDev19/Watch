import 'dart:math';

import 'package:flutter/material.dart';

import '../core/colors/VColors.dart';
import '../features/movie/domain/models/EpisodeList.dart';

class MethodHelperUtils {
  MethodHelperUtils._();

  static int getCurrentEpisode(EpisodeList currentEpisode) {
    return (currentEpisode.slug == "Full" ||
            currentEpisode.slug == "full" ||
            currentEpisode.slug == "FULL" ||
            currentEpisode.slug.isEmpty ||
            currentEpisode.name == "Full" ||
            currentEpisode.name == "full" ||
            currentEpisode.name == "FULL" ||
            currentEpisode.name.isEmpty)
        ? 1
        : int.tryParse(currentEpisode.slug) == null
        ? 1
        : int.parse(currentEpisode.slug);
  }

  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(content)));
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: VColors.colorIcon),
      ),
    );
  }

  static String randomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  static String formatTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    final diffInSeconds = diff.inSeconds;
    final diffInMinutes = diff.inMinutes;
    final diffInHours = diff.inHours;
    final diffInDays = diff.inDays;
    if (diffInSeconds < 60) {
      return "Just now";
    } else if (diffInMinutes < 60) {
      return diffInMinutes > 1 ? "$diffInMinutes minutes ago" : "1 minute ago";
    } else if (diffInHours < 24) {
      return diffInHours > 1 ? "$diffInHours hours ago" : "1 hour ago";
    } else {
      return diffInDays > 1 ? "$diffInDays days ago" : "1 day ago";
    }
  }
}
