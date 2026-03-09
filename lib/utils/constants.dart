import 'package:flutter/cupertino.dart';

class Constants {
  Constants._();

  static const String baseImageUrl = "https://img.ophim.live/uploads/movies/";

  static double getHeightScreen(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double getWidthScreen(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double calculateFontSize(BuildContext context, double mul){
    return getWidthScreen(context) / 100 * 4.5 * mul;
  }

}