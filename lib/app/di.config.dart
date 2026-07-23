// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../data/data_source/category_content_data_source.dart' as _i960;
import '../data/data_source/classification_category_data_source.dart' as _i990;
import '../data/data_source/download_data_source.dart' as _i674;
import '../data/data_source/get_drawer_remote_data_source.dart' as _i1025;
import '../data/data_source/get_image_category_data_source.dart' as _i460;
import '../data/data_source/list_app_remote_data_source.dart' as _i720;
import '../data/network/app_api.dart' as _i563;
import '../data/network/dio_client.dart' as _i765;
import '../data/network/network_info.dart' as _i371;
import '../data/repository_impl/category_content_repository_impl.dart' as _i724;
import '../data/repository_impl/classification_category_repository_impl.dart'
    as _i523;
import '../data/repository_impl/download_repository_impl.dart' as _i37;
import '../data/repository_impl/get_drawer_repository_impl.dart' as _i795;
import '../data/repository_impl/get_image_catgegory_repository_impl.dart'
    as _i622;
import '../data/repository_impl/list_app_repository_impl.dart' as _i38;
import '../domain/repository/category_content_repository.dart' as _i908;
import '../domain/repository/classification_category_repository.dart' as _i925;
import '../domain/repository/download_repository.dart' as _i885;
import '../domain/repository/get_drawer_repository.dart' as _i281;
import '../domain/repository/get_image_category_repository.dart' as _i981;
import '../domain/repository/list_app_repository.dart' as _i164;
import '../domain/usecase/category_content._usecase.dart' as _i360;
import '../domain/usecase/classification_category_usecase.dart' as _i64;
import '../domain/usecase/download_uecase.dart' as _i675;
import '../domain/usecase/get_darwer_usecase.dart' as _i224;
import '../domain/usecase/get_image_category_usecase.dart' as _i410;
import '../domain/usecase/list_app_usecase.dart' as _i895;
import '../presentation/home/category_content_classification_cubit/category_content_%20classification_cubit.dart'
    as _i519;
import '../presentation/home/classification_category_cubit/classification_category_cubit.dart'
    as _i810;
import '../presentation/home/download_cubit/download_cubit.dart' as _i475;
import '../presentation/home/get_category_content_cubit/get_category_content_cubit.dart'
    as _i626;
import '../presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart'
    as _i694;
import '../presentation/home/list_app_cubit/list_app_cubit.dart' as _i951;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => appModule.internetConnectionChecker,
    );
    gh.lazySingleton<_i765.DioFactory>(() => _i765.DioFactory());
    gh.lazySingleton<_i371.NetworkInfo>(
      () => _i371.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.lazySingleton<_i361.Dio>(() => appModule.dio(gh<_i765.DioFactory>()));
    gh.lazySingleton<_i674.DownloadDataSource>(
      () => _i674.DownloadRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i563.AppServiceClient>(
      () => appModule.appServiceClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i960.CategoryContentRemoteDataSource>(
      () => _i960.CategoryContentRemoteDataSourceImpl(
        gh<_i563.AppServiceClient>(),
      ),
    );
    gh.lazySingleton<_i1025.GetDrawerRemoteDataSource>(
      () => _i1025.GetDrawerRemoteDataSourceImpl(gh<_i563.AppServiceClient>()),
    );
    gh.lazySingleton<_i990.GetClassificationCategoryRemoteDataSource>(
      () => _i990.GetClassificationCategoryRemoteDataSourceImpl(
        gh<_i563.AppServiceClient>(),
      ),
    );
    gh.lazySingleton<_i460.GetImageCategoryRemoteDataSource>(
      () => _i460.GetImageCategoryRemoteDataSourceImpl(
        gh<_i563.AppServiceClient>(),
      ),
    );
    gh.lazySingleton<_i885.DownloadRepository>(
      () => _i37.DownloadRepositoryImpl(gh<_i674.DownloadDataSource>()),
    );
    gh.lazySingleton<_i720.RemoteDataSource>(
      () => _i720.RemoteDataSourceImpl(gh<_i563.AppServiceClient>()),
    );
    gh.lazySingleton<_i981.GetImageCategoryRepository>(
      () => _i622.GetImageCategoryRepositoryImpl(
        gh<_i460.GetImageCategoryRemoteDataSource>(),
        gh<_i371.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i281.GetDrawerRepository>(
      () => _i795.GetDrawerRepositoryImpl(
        gh<_i1025.GetDrawerRemoteDataSource>(),
        gh<_i371.NetworkInfo>(),
      ),
    );
    gh.factory<_i410.GetImageCategoryUsecase>(
      () =>
          _i410.GetImageCategoryUsecase(gh<_i981.GetImageCategoryRepository>()),
    );
    gh.lazySingleton<_i925.GetClassificationCategoryRepository>(
      () => _i523.GetClassificationCategoryRepositoryImpl(
        gh<_i990.GetClassificationCategoryRemoteDataSource>(),
        gh<_i371.NetworkInfo>(),
      ),
    );
    gh.factory<_i675.DownLoadUsecase>(
      () => _i675.DownLoadUsecase(gh<_i885.DownloadRepository>()),
    );
    gh.lazySingleton<_i164.ListAppRepository>(
      () => _i38.ListAppRepositoryImpl(
        gh<_i720.RemoteDataSource>(),
        gh<_i371.NetworkInfo>(),
      ),
    );
    gh.factory<_i895.ListAppUsecase>(
      () => _i895.ListAppUsecase(gh<_i164.ListAppRepository>()),
    );
    gh.lazySingleton<_i908.CategoryContentRepository>(
      () => _i724.CategoryContentRepositoryImpl(
        gh<_i960.CategoryContentRemoteDataSource>(),
        gh<_i371.NetworkInfo>(),
      ),
    );
    gh.factory<_i224.GetDarwerUsecase>(
      () => _i224.GetDarwerUsecase(gh<_i281.GetDrawerRepository>()),
    );
    gh.factory<_i626.GetCategoryContentCubit>(
      () => _i626.GetCategoryContentCubit(gh<_i410.GetImageCategoryUsecase>()),
    );
    gh.factory<_i64.GetClassificationCategoryUsecase>(
      () => _i64.GetClassificationCategoryUsecase(
        gh<_i925.GetClassificationCategoryRepository>(),
      ),
    );
    gh.lazySingleton<_i475.DownloadCubit>(
      () => _i475.DownloadCubit(gh<_i675.DownLoadUsecase>()),
    );
    gh.factory<_i810.ClassificationCategoryCubit>(
      () => _i810.ClassificationCategoryCubit(
        gh<_i64.GetClassificationCategoryUsecase>(),
      ),
    );
    gh.factory<_i360.GetCategoryContentUsecase>(
      () => _i360.GetCategoryContentUsecase(
        gh<_i908.CategoryContentRepository>(),
      ),
    );
    gh.factory<_i951.ListAppCubit>(
      () => _i951.ListAppCubit(gh<_i895.ListAppUsecase>()),
    );
    gh.factory<_i694.GetDrawerDataCubit>(
      () => _i694.GetDrawerDataCubit(gh<_i224.GetDarwerUsecase>()),
    );
    gh.factory<_i519.GetCategoryContentClassificationCubit>(
      () => _i519.GetCategoryContentClassificationCubit(
        gh<_i360.GetCategoryContentUsecase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
