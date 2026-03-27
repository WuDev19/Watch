import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/repositories/MovieRepository.dart';

@lazySingleton
class GetCountryUseCase {
  final MovieRepository _movieRepository;

  GetCountryUseCase(this._movieRepository);

  Future<List<CountryModel>> execute() => _movieRepository.getCountry();

}