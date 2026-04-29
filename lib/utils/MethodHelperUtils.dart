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
}
