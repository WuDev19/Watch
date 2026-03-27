import 'package:isar_community/isar.dart';
part 'CountryLocal.g.dart';

@collection
class CountryLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  String countryId;
  @Index()
  String countryName;
  String countrySlug;

  CountryLocal(this.countryId, this.countryName, this.countrySlug);
}