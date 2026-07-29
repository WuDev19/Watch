import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/models/FavoriteMovieModel.dart';

class FavoriteState extends Equatable {
  final List<FavoriteMovieModel> favorite;
  final bool isLoadingFavorite;
  final String? errorFavorite;
  final int currentPageFavorite;
  final bool isLastFavorite;

  const FavoriteState({
    this.favorite = const [],
    this.isLoadingFavorite = false,
    this.errorFavorite,
    this.currentPageFavorite = -1,
    this.isLastFavorite = false,
  });

  FavoriteState copyWith({
    List<FavoriteMovieModel>? favorite,
    bool? isLoadingFavorite,
    String? errorFavorite,
    int? currentPageFavorite,
    bool? isLastFavorite,
  }) {
    return FavoriteState(
      favorite: favorite ?? this.favorite,
      isLoadingFavorite: isLoadingFavorite ?? this.isLoadingFavorite,
      errorFavorite: errorFavorite ?? this.errorFavorite,
      currentPageFavorite: currentPageFavorite ?? this.currentPageFavorite,
      isLastFavorite: isLastFavorite ?? this.isLastFavorite,
    );
  }

  @override
  List<Object?> get props => [
    favorite,
    isLoadingFavorite,
    errorFavorite,
    currentPageFavorite,
    isLastFavorite,
  ];
}
