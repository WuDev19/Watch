// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;

import '../../features/movie/data/datasources/remote/api/MovieApi.dart'
    as _i500;
import '../../features/movie/data/repositories/MovieRepositoryImpl.dart'
    as _i709;
import '../../features/movie/domain/repositories/MovieRepository.dart' as _i503;
import '../../features/movie/domain/usecases/GetAllYearUseCase.dart' as _i414;
import '../../features/movie/domain/usecases/GetCategoriesUseCase.dart'
    as _i716;
import '../../features/movie/domain/usecases/GetCountryUseCase.dart' as _i253;
import '../../features/movie/domain/usecases/GetMovieActorsUseCase.dart'
    as _i392;
import '../../features/movie/domain/usecases/GetMovieDetailsInfoUseCase.dart'
    as _i244;
import '../../features/movie/domain/usecases/HomePageMovieUseCase.dart'
    as _i755;
import '../../features/movie/domain/usecases/SearchMovieAccordingToCategoryUseCase.dart'
    as _i63;
import '../../features/movie/domain/usecases/SearchMovieAccordingToCountryUseCase.dart'
    as _i123;
import '../../features/movie/domain/usecases/SearchMovieAccordingToYearUseCase.dart'
    as _i2;
import '../../features/movie/domain/usecases/SearchMovieUseCase.dart' as _i68;
import '../../features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart'
    as _i862;
import '../../features/movie/presentation/home/state_management/HomeBloc.dart'
    as _i309;
import '../../features/movie/presentation/home/state_management/ScalePageBloc.dart'
    as _i673;
import '../../features/movie/presentation/search/state_management/SearchPageManagement.dart'
    as _i964;
import 'IsarModule.dart' as _i448;
import 'NetworkModule.dart' as _i802;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final isarModule = _$IsarModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i673.ScalePageBloc>(() => _i673.ScalePageBloc());
    await gh.singletonAsync<_i214.Isar>(
      () => isarModule.provideIsar(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => networkModule.provideDio());
    gh.singleton<_i500.MovieApi>(() => _i500.MovieApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i503.MovieRepository>(
      () => _i709.MovieRepositoryImpl(gh<_i500.MovieApi>(), gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i716.GetCategoriesUseCase>(
      () => _i716.GetCategoriesUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i392.GetMovieActorsUseCase>(
      () => _i392.GetMovieActorsUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i244.GetMovieDetailsInfoUseCase>(
      () => _i244.GetMovieDetailsInfoUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i755.HomePageMovieUseCase>(
      () => _i755.HomePageMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i63.SearchMovieAccordingToCategoryUseCase>(
      () => _i63.SearchMovieAccordingToCategoryUseCase(
        gh<_i503.MovieRepository>(),
      ),
    );
    gh.lazySingleton<_i68.SearchMovieUseCase>(
      () => _i68.SearchMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i253.GetCountryUseCase>(
      () => _i253.GetCountryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i414.GetAllYearUseCase>(
      () => _i414.GetAllYearUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i123.SearchMovieAccordingToCountryUseCase>(
      () => _i123.SearchMovieAccordingToCountryUseCase(
        gh<_i503.MovieRepository>(),
      ),
    );
    gh.lazySingleton<_i2.SearchMovieAccordingToYearUseCase>(
      () => _i2.SearchMovieAccordingToYearUseCase(gh<_i503.MovieRepository>()),
    );
    gh.factory<_i309.HomeBloc>(
      () => _i309.HomeBloc(gh<_i755.HomePageMovieUseCase>()),
    );
    gh.factory<_i862.MovieDetailManagement>(
      () => _i862.MovieDetailManagement(
        gh<_i244.GetMovieDetailsInfoUseCase>(),
        gh<_i392.GetMovieActorsUseCase>(),
        gh<_i63.SearchMovieAccordingToCategoryUseCase>(),
      ),
    );
    gh.factory<_i964.SearchPageManagement>(
      () => _i964.SearchPageManagement(
        gh<_i68.SearchMovieUseCase>(),
        gh<_i716.GetCategoriesUseCase>(),
        gh<_i63.SearchMovieAccordingToCategoryUseCase>(),
        gh<_i253.GetCountryUseCase>(),
        gh<_i414.GetAllYearUseCase>(),
        gh<_i123.SearchMovieAccordingToCountryUseCase>(),
        gh<_i2.SearchMovieAccordingToYearUseCase>(),
      ),
    );
    return this;
  }
}

class _$IsarModule extends _i448.IsarModule {}

class _$NetworkModule extends _i802.NetworkModule {}
