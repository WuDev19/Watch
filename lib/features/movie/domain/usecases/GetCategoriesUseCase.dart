import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/CategoryModel.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetCategoriesUseCase {
  final MovieRepository _movieRepository;

  GetCategoriesUseCase(this._movieRepository);

  Future<List<CategoryModel>> execute() => _movieRepository.categories();

}
