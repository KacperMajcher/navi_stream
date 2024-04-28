// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:navi_stream/dependencies/injection_container.dart' as _i10;
import 'package:navi_stream/features/authButRiverpod/services/storage_service.dart'
    as _i3;
import 'package:navi_stream/features/home/data/data_sources/channels_remote_data_source.dart'
    as _i7;
import 'package:navi_stream/features/home/data/data_sources/packages_remote_data_source.dart'
    as _i5;
import 'package:navi_stream/features/home/data/repositories/channel_repository.dart'
    as _i8;
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart'
    as _i6;
import 'package:navi_stream/features/home/pages/cubit/home_cubit.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.StorageService>(() => _i3.StorageService());
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i4.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.factory<_i5.PackagesRemoteDioDataSource>(
        () => _i5.PackagesRemoteDioDataSource(gh<_i4.Dio>()));
    gh.factory<_i6.PackagesRepository>(() => _i6.PackagesRepository(
          gh<_i5.PackagesRemoteDioDataSource>(),
          gh<_i3.StorageService>(),
        ));
    gh.factory<_i7.ChannelsRemoteDataSource>(
        () => _i7.ChannelsRemoteDataSource(gh<_i4.Dio>()));
    gh.factory<_i8.ChannelsRepository>(() => _i8.ChannelsRepository(
          gh<_i7.ChannelsRemoteDataSource>(),
          gh<_i3.StorageService>(),
        ));
    gh.factory<_i9.HomeCubit>(() => _i9.HomeCubit(
          packagesRepository: gh<_i6.PackagesRepository>(),
          channelsRepository: gh<_i8.ChannelsRepository>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
