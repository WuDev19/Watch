import 'package:flutter/cupertino.dart';

class Constants {
  Constants._();

  static const String baseImageUrl = "https://img.ophim.live/uploads/movies/";
  static const String errorImage = "Image loading error";
  static const String favoriteMovie = "Favorite Movie";
  static const String watchingMovie = "Watching Movie";
  static const String watchedMovie = "Watched Movie";
  static const String retry = "Retry";
  static const String nothing = "Nothing to show";
  static const String forgotPassword = "Forgot password?";
  static const String appName = "Watch";
  static const String logoutNotification = "Logout successfully";
  static const String emailKey = "email";
  static const String passwordKey = "password";
  static const String newEmailKey = "newEmail";
  static const double rateScroll = 0.9;
  static const int defaultSize = 24;

  static double getHeightScreen(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getWidthScreen(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double calculateFontSize(BuildContext context, double mul) {
    return getWidthScreen(context) / 100 * 4.5 * mul;
  }

  static double getImageWidth(BuildContext context) {
    return (getWidthScreen(context) - 32) / 3;
  }

  static double getImageHeight(BuildContext context) {
    return getImageWidth(context) * 1.5 + 40;
  }
}
