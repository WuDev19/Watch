import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:movie_app/features/movie/data/datasources/local/CategoryLocal.dart';
import 'package:movie_app/features/movie/data/datasources/local/HistorySearchEntity.dart';
import 'package:path_provider/path_provider.dart';

@module
abstract class IsarModule {
  @singleton
  @preResolve
  Future<Isar> provideIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [HistorySearchEntitySchema, CategoryLocalSchema],
      directory: dir.path,
      name: "movie_app",
    );
  }
}
