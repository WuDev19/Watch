import 'package:movie_app/features/movie/data/datasources/local/entity/CountryLocal.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';

abstract class MovieLocalMapper {
  static CountryModel mapToCountryModel(CountryLocal local) {
    return CountryModel(local.countryName, local.countrySlug);
  }
}
