// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloudinary_public/cloudinary_public.dart' as _i524;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/third-source/base/AuthRemoteDataSource.dart'
    as _i633;
import '../../features/auth/data/datasources/third-source/impl/AuthRemoteDataSourceImpl.dart'
    as _i50;
import '../../features/auth/data/repositories/AuthRepositoryImpl.dart' as _i763;
import '../../features/auth/domain/repositories/AuthRepository.dart' as _i966;
import '../../features/auth/domain/usecases/CheckLoginUseCase.dart' as _i163;
import '../../features/auth/domain/usecases/LoginUseCase.dart' as _i934;
import '../../features/auth/domain/usecases/LogoutUseCase.dart' as _i672;
import '../../features/auth/domain/usecases/ReauthenticateUseCase.dart'
    as _i436;
import '../../features/auth/domain/usecases/SendEmailResetPasswordUseCase.dart'
    as _i1054;
import '../../features/auth/domain/usecases/SignUpUseCase.dart' as _i47;
import '../../features/auth/presentation/auth/state_management/LoginCubit.dart'
    as _i582;
import '../../features/auth/presentation/auth/state_management/SignUpCubit.dart'
    as _i276;
import '../../features/movie/data/datasources/remote/api/MovieApi.dart'
    as _i500;
import '../../features/movie/data/datasources/service/ForegroundServiceDataSource.dart'
    as _i17;
import '../../features/movie/data/datasources/third-source/base/CommentRemoteDataSource.dart'
    as _i673;
import '../../features/movie/data/datasources/third-source/base/UserRemoteDataSource.dart'
    as _i792;
import '../../features/movie/data/datasources/third-source/impl/CommentRemoteDataSourceImpl.dart'
    as _i928;
import '../../features/movie/data/datasources/third-source/impl/UserRemoteDataSourceImpl.dart'
    as _i953;
import '../../features/movie/data/repositories/CommentRepositoryImpl.dart'
    as _i1021;
import '../../features/movie/data/repositories/DownloadRepositoryImpl.dart'
    as _i764;
import '../../features/movie/data/repositories/MovieRepositoryImpl.dart'
    as _i709;
import '../../features/movie/data/repositories/UserRepositoryImpl.dart' as _i54;
import '../../features/movie/domain/repositories/CommentRepository.dart'
    as _i799;
import '../../features/movie/domain/repositories/DownloadRepository.dart'
    as _i1025;
import '../../features/movie/domain/repositories/MovieRepository.dart' as _i503;
import '../../features/movie/domain/repositories/UserRepository.dart' as _i253;
import '../../features/movie/domain/usecases/CheckFavoriteMovieUseCase.dart'
    as _i35;
import '../../features/movie/domain/usecases/DeleteCommentUseCase.dart'
    as _i236;
import '../../features/movie/domain/usecases/DeleteFavoriteUseCase.dart'
    as _i380;
import '../../features/movie/domain/usecases/DeleteListFavoriteMovieUseCase.dart'
    as _i193;
import '../../features/movie/domain/usecases/DeleteMovieHistoryUseCase.dart'
    as _i559;
import '../../features/movie/domain/usecases/DownloadMovieUseCase.dart' as _i54;
import '../../features/movie/domain/usecases/GetAllYearUseCase.dart' as _i414;
import '../../features/movie/domain/usecases/GetCategoriesUseCase.dart'
    as _i716;
import '../../features/movie/domain/usecases/GetCommentOfMovieUseCase.dart'
    as _i799;
import '../../features/movie/domain/usecases/GetCountryUseCase.dart' as _i253;
import '../../features/movie/domain/usecases/GetLastWatchedMovieUseCase.dart'
    as _i663;
import '../../features/movie/domain/usecases/GetMovieActorsUseCase.dart'
    as _i392;
import '../../features/movie/domain/usecases/GetMovieDetailsInfoUseCase.dart'
    as _i244;
import '../../features/movie/domain/usecases/GetMovieWatchingUseCase.dart'
    as _i332;
import '../../features/movie/domain/usecases/GetMyFavoriteMovieUseCase.dart'
    as _i357;
import '../../features/movie/domain/usecases/GetWatchedMovieUseCase.dart'
    as _i673;
import '../../features/movie/domain/usecases/HomePageMovieUseCase.dart'
    as _i755;
import '../../features/movie/domain/usecases/PostCommentUseCase.dart' as _i514;
import '../../features/movie/domain/usecases/SaveFavoriteMovieUseCase.dart'
    as _i582;
import '../../features/movie/domain/usecases/SaveMovieHistoryUseCase.dart'
    as _i749;
import '../../features/movie/domain/usecases/SearchMovieAccordingToCategoryUseCase.dart'
    as _i63;
import '../../features/movie/domain/usecases/SearchMovieAccordingToCountryUseCase.dart'
    as _i123;
import '../../features/movie/domain/usecases/SearchMovieAccordingToYearUseCase.dart'
    as _i2;
import '../../features/movie/domain/usecases/SearchMovieUseCase.dart' as _i68;
import '../../features/movie/domain/usecases/SearchUserUseCase.dart' as _i316;
import '../../features/movie/presentation/detail_movie/state_management/MovieDetailManagement.dart'
    as _i862;
import '../../features/movie/presentation/home/state_management/HomeBloc.dart'
    as _i309;
import '../../features/movie/presentation/home/state_management/ScalePageBloc.dart'
    as _i673;
import '../../features/movie/presentation/search/state_management/SearchPageManagement.dart'
    as _i964;
import '../../features/movie/presentation/setting/state_managment/SettingScreenManagement.dart'
    as _i874;
import '../../features/movie/presentation/watch_movie/state_management/WatchMovieManagement.dart'
    as _i816;
import '../../features/profile/data/datasources/third-source/base/PersonalRemoteDataSource.dart'
    as _i957;
import '../../features/profile/data/datasources/third-source/impl/PersonalRemoteDataSourceImpl.dart'
    as _i779;
import '../../features/profile/data/repositories/PersonalRepositoryImpl.dart'
    as _i197;
import '../../features/profile/domain/repositories/PersonalRepository.dart'
    as _i11;
import '../../features/profile/domain/usecases/CheckVerifiedNewEmailUseCase.dart'
    as _i304;
import '../../features/profile/domain/usecases/DeleteAllFavoriteMovieUseCase.dart'
    as _i188;
import '../../features/profile/domain/usecases/DeleteAllMovieHistoryUseCase.dart'
    as _i443;
import '../../features/profile/domain/usecases/GetMyHistoryUseCase.dart'
    as _i1012;
import '../../features/profile/domain/usecases/GetMyProfileUseCase.dart'
    as _i39;
import '../../features/profile/domain/usecases/SearchFavoriteMovieUseCase.dart'
    as _i809;
import '../../features/profile/domain/usecases/SearchMovieHistoryUseCase.dart'
    as _i430;
import '../../features/profile/domain/usecases/UpdateAvatarUseCase.dart'
    as _i69;
import '../../features/profile/domain/usecases/UpdateEmailUseCase.dart'
    as _i841;
import '../../features/profile/domain/usecases/UpdateNameUseCase.dart' as _i997;
import '../../features/profile/presentation/favorite/state_management/FavoriteManagement.dart'
    as _i751;
import '../../features/profile/presentation/history/state_management/HistoryManagement.dart'
    as _i815;
import '../../features/profile/presentation/profile/state_management/ProfileManagement.dart'
    as _i249;
import '../../utils/FileUtils.dart' as _i281;
import 'CloudinaryModule.dart' as _i656;
import 'FirebaseModule.dart' as _i570;
import 'IsarModule.dart' as _i448;
import 'NetworkModule.dart' as _i802;
import 'SharePreferencesModule.dart' as _i950;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharePreferencesModule = _$SharePreferencesModule();
    final isarModule = _$IsarModule();
    final networkModule = _$NetworkModule();
    final cloudinaryModule = _$CloudinaryModule();
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharePreferencesModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i673.ScalePageBloc>(() => _i673.ScalePageBloc());
    await gh.singletonAsync<_i214.Isar>(
      () => isarModule.provideIsar(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => networkModule.provideDio());
    gh.lazySingleton<_i524.CloudinaryPublic>(
      () => cloudinaryModule.provideCloudinary(),
    );
    gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseModule.provideFirebaseAuth(),
    );
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseModule.provideFirebaseFirestore(),
    );
    gh.lazySingleton<_i17.ForegroundServiceDataSource>(
      () => _i17.ForegroundServiceDataSource(),
    );
    gh.lazySingleton<_i281.FileUtils>(() => _i281.FileUtils());
    gh.lazySingleton<_i1025.DownloadRepository>(
      () => _i764.DownloadRepositoryImpl(
        gh<_i17.ForegroundServiceDataSource>(),
        gh<_i281.FileUtils>(),
      ),
    );
    gh.lazySingleton<_i792.UserRemoteDataSource>(
      () => _i953.UserRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i54.DownloadMovieUseCase>(
      () => _i54.DownloadMovieUseCase(gh<_i1025.DownloadRepository>()),
    );
    gh.singleton<_i500.MovieApi>(() => _i500.MovieApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i957.PersonalRemoteDataSource>(
      () => _i779.PersonalRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i524.CloudinaryPublic>(),
      ),
    );
    gh.lazySingleton<_i673.CommentRemoteDataSource>(
      () => _i928.CommentRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i253.UserRepository>(
      () => _i54.UserRepositoryImpl(gh<_i792.UserRemoteDataSource>()),
    );
    gh.lazySingleton<_i633.AuthRemoteDataSource>(
      () => _i50.AuthRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i503.MovieRepository>(
      () => _i709.MovieRepositoryImpl(gh<_i500.MovieApi>(), gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i11.PersonalRepository>(
      () => _i197.PersonalRepositoryImpl(
        gh<_i957.PersonalRemoteDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i799.CommentRepository>(
      () => _i1021.CommentRepositoryImpl(gh<_i673.CommentRemoteDataSource>()),
    );
    gh.lazySingleton<_i966.AuthRepository>(
      () => _i763.AuthRepositoryImpl(
        gh<_i633.AuthRemoteDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i304.CheckVerifiedNewEmailUseCase>(
      () => _i304.CheckVerifiedNewEmailUseCase(gh<_i11.PersonalRepository>()),
    );
    gh.lazySingleton<_i39.GetMyProfileUseCase>(
      () => _i39.GetMyProfileUseCase(gh<_i11.PersonalRepository>()),
    );
    gh.lazySingleton<_i69.UpdateAvatarUseCase>(
      () => _i69.UpdateAvatarUseCase(gh<_i11.PersonalRepository>()),
    );
    gh.lazySingleton<_i841.UpdateEmailUseCase>(
      () => _i841.UpdateEmailUseCase(gh<_i11.PersonalRepository>()),
    );
    gh.lazySingleton<_i997.UpdateNameUseCase>(
      () => _i997.UpdateNameUseCase(gh<_i11.PersonalRepository>()),
    );
    gh.lazySingleton<_i316.SearchUserUseCase>(
      () => _i316.SearchUserUseCase(gh<_i253.UserRepository>()),
    );
    gh.factory<_i663.GetLastWatchedMovieUseCase>(
      () => _i663.GetLastWatchedMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i35.CheckFavoriteMovieUseCase>(
      () => _i35.CheckFavoriteMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i380.DeleteFavoriteUseCase>(
      () => _i380.DeleteFavoriteUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i193.DeleteListFavoriteMovieUseCase>(
      () => _i193.DeleteListFavoriteMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i559.DeleteMovieHistoryUseCase>(
      () => _i559.DeleteMovieHistoryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i414.GetAllYearUseCase>(
      () => _i414.GetAllYearUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i716.GetCategoriesUseCase>(
      () => _i716.GetCategoriesUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i253.GetCountryUseCase>(
      () => _i253.GetCountryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i392.GetMovieActorsUseCase>(
      () => _i392.GetMovieActorsUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i244.GetMovieDetailsInfoUseCase>(
      () => _i244.GetMovieDetailsInfoUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i332.GetMovieWatchingUseCase>(
      () => _i332.GetMovieWatchingUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i357.GetMyFavoriteMovieUseCase>(
      () => _i357.GetMyFavoriteMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i673.GetWatchedMovieUseCase>(
      () => _i673.GetWatchedMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i755.HomePageMovieUseCase>(
      () => _i755.HomePageMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i582.SaveFavoriteMovieUseCase>(
      () => _i582.SaveFavoriteMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i749.SaveMovieHistoryUseCase>(
      () => _i749.SaveMovieHistoryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i63.SearchMovieAccordingToCategoryUseCase>(
      () => _i63.SearchMovieAccordingToCategoryUseCase(
        gh<_i503.MovieRepository>(),
      ),
    );
    gh.lazySingleton<_i123.SearchMovieAccordingToCountryUseCase>(
      () => _i123.SearchMovieAccordingToCountryUseCase(
        gh<_i503.MovieRepository>(),
      ),
    );
    gh.lazySingleton<_i2.SearchMovieAccordingToYearUseCase>(
      () => _i2.SearchMovieAccordingToYearUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i68.SearchMovieUseCase>(
      () => _i68.SearchMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i188.DeleteAllFavoriteMovieUseCase>(
      () => _i188.DeleteAllFavoriteMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i443.DeleteAllMovieHistoryUseCase>(
      () => _i443.DeleteAllMovieHistoryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i1012.GetMyHistoryUseCase>(
      () => _i1012.GetMyHistoryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i809.SearchFavoriteMovieUseCase>(
      () => _i809.SearchFavoriteMovieUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i430.SearchMovieHistoryUseCase>(
      () => _i430.SearchMovieHistoryUseCase(gh<_i503.MovieRepository>()),
    );
    gh.lazySingleton<_i163.CheckLoginUseCase>(
      () => _i163.CheckLoginUseCase(gh<_i966.AuthRepository>()),
    );
    gh.lazySingleton<_i934.LoginUseCase>(
      () => _i934.LoginUseCase(gh<_i966.AuthRepository>()),
    );
    gh.lazySingleton<_i672.LogoutUseCase>(
      () => _i672.LogoutUseCase(gh<_i966.AuthRepository>()),
    );
    gh.lazySingleton<_i436.ReauthenticateUseCase>(
      () => _i436.ReauthenticateUseCase(gh<_i966.AuthRepository>()),
    );
    gh.lazySingleton<_i1054.SendEmailResetPasswordUseCase>(
      () => _i1054.SendEmailResetPasswordUseCase(gh<_i966.AuthRepository>()),
    );
    gh.lazySingleton<_i47.SignUpUseCase>(
      () => _i47.SignUpUseCase(gh<_i966.AuthRepository>()),
    );
    gh.lazySingleton<_i236.DeleteCommentUseCase>(
      () => _i236.DeleteCommentUseCase(gh<_i799.CommentRepository>()),
    );
    gh.lazySingleton<_i799.GetCommentOfMovieUseCase>(
      () => _i799.GetCommentOfMovieUseCase(gh<_i799.CommentRepository>()),
    );
    gh.lazySingleton<_i514.PostCommentUseCase>(
      () => _i514.PostCommentUseCase(gh<_i799.CommentRepository>()),
    );
    gh.factory<_i816.WatchMovieManagement>(
      () => _i816.WatchMovieManagement(
        gh<_i749.SaveMovieHistoryUseCase>(),
        gh<_i35.CheckFavoriteMovieUseCase>(),
        gh<_i582.SaveFavoriteMovieUseCase>(),
        gh<_i380.DeleteFavoriteUseCase>(),
        gh<_i54.DownloadMovieUseCase>(),
        gh<_i39.GetMyProfileUseCase>(),
        gh<_i514.PostCommentUseCase>(),
        gh<_i236.DeleteCommentUseCase>(),
        gh<_i799.GetCommentOfMovieUseCase>(),
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
    gh.factory<_i309.HomeBloc>(
      () => _i309.HomeBloc(
        gh<_i755.HomePageMovieUseCase>(),
        gh<_i663.GetLastWatchedMovieUseCase>(),
      ),
    );
    gh.factory<_i751.FavoriteManagement>(
      () => _i751.FavoriteManagement(
        gh<_i357.GetMyFavoriteMovieUseCase>(),
        gh<_i188.DeleteAllFavoriteMovieUseCase>(),
        gh<_i193.DeleteListFavoriteMovieUseCase>(),
        gh<_i809.SearchFavoriteMovieUseCase>(),
      ),
    );
    gh.factory<_i862.MovieDetailManagement>(
      () => _i862.MovieDetailManagement(
        gh<_i244.GetMovieDetailsInfoUseCase>(),
        gh<_i392.GetMovieActorsUseCase>(),
        gh<_i63.SearchMovieAccordingToCategoryUseCase>(),
        gh<_i749.SaveMovieHistoryUseCase>(),
        gh<_i35.CheckFavoriteMovieUseCase>(),
        gh<_i582.SaveFavoriteMovieUseCase>(),
        gh<_i380.DeleteFavoriteUseCase>(),
        gh<_i316.SearchUserUseCase>(),
      ),
    );
    gh.factory<_i582.LoginCubit>(
      () => _i582.LoginCubit(
        gh<_i934.LoginUseCase>(),
        gh<_i1054.SendEmailResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i874.SettingScreenManagement>(
      () => _i874.SettingScreenManagement(
        gh<_i357.GetMyFavoriteMovieUseCase>(),
        gh<_i332.GetMovieWatchingUseCase>(),
        gh<_i673.GetWatchedMovieUseCase>(),
        gh<_i193.DeleteListFavoriteMovieUseCase>(),
        gh<_i559.DeleteMovieHistoryUseCase>(),
        gh<_i163.CheckLoginUseCase>(),
        gh<_i672.LogoutUseCase>(),
      ),
    );
    gh.factory<_i815.HistoryManagement>(
      () => _i815.HistoryManagement(
        gh<_i1012.GetMyHistoryUseCase>(),
        gh<_i430.SearchMovieHistoryUseCase>(),
        gh<_i443.DeleteAllMovieHistoryUseCase>(),
        gh<_i559.DeleteMovieHistoryUseCase>(),
      ),
    );
    gh.factory<_i276.SignUpCubit>(
      () => _i276.SignUpCubit(gh<_i47.SignUpUseCase>()),
    );
    gh.factory<_i249.ProfileManagement>(
      () => _i249.ProfileManagement(
        gh<_i39.GetMyProfileUseCase>(),
        gh<_i69.UpdateAvatarUseCase>(),
        gh<_i672.LogoutUseCase>(),
        gh<_i841.UpdateEmailUseCase>(),
        gh<_i997.UpdateNameUseCase>(),
        gh<_i436.ReauthenticateUseCase>(),
        gh<_i304.CheckVerifiedNewEmailUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharePreferencesModule extends _i950.SharePreferencesModule {}

class _$IsarModule extends _i448.IsarModule {}

class _$NetworkModule extends _i802.NetworkModule {}

class _$CloudinaryModule extends _i656.CloudinaryModule {}

class _$FirebaseModule extends _i570.FirebaseModule {}
