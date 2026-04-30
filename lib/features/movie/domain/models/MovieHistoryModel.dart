import 'package:movie_app/features/movie/domain/models/CombineDetailAndWatch.dart';

class MovieHistoryModel {
  CombineDetailAndWatch combineDetailAndWatch;
  int currentEpisode;

  MovieHistoryModel({
    required this.combineDetailAndWatch,
    required this.currentEpisode,
  });
}
