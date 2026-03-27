import 'package:isar_community/isar.dart';

part 'HistorySearchEntity.g.dart';

@collection
class HistorySearchEntity {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value)
  late String movieName;
  @Index()
  late DateTime searchTime;
}
