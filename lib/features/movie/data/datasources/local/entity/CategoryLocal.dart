import 'package:isar_community/isar.dart';

part 'CategoryLocal.g.dart';

@collection
class CategoryLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  String categoryId;
  @Index()
  String categoryName;
  String categorySlug;

  CategoryLocal(this.categoryId, this.categoryName, this.categorySlug);
}
