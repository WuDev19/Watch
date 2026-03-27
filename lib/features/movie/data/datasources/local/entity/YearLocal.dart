import 'package:isar_community/isar.dart';
part 'YearLocal.g.dart';
@collection
class YearLocal {
  Id id = Isar.autoIncrement;
  int year;

  YearLocal(this.year);
}
