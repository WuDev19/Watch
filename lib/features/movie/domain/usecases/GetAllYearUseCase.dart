import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetAllYearUseCase {
  final MovieRepository _movieRepository;

  GetAllYearUseCase(this._movieRepository);

  Future<List<YearModel>> execute() => _movieRepository.getYears();
}
