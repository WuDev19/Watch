import 'package:movie_app/features/movie/data/datasources/local/entity/CountryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/entity/YearLocal.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';

abstract class MovieLocalMapper {
  static CountryModel mapToCountryModel(CountryLocal local) {
    return CountryModel(local.countryName, local.countrySlug);
  }

  static YearModel mapToYearModel(YearLocal local) {
    return YearModel(local.year);
  }
}
