// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:navi_stream/dependencies/injection_container.dart' as _i13;
import 'package:navi_stream/features/auth/data/data_source/auth_local_data_source.dart'
    as _i3;
import 'package:navi_stream/features/auth/data/data_source/login_remote_data_source.dart'
    as _i4;
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart'
    as _i5;
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart'
    as _i7;
import 'package:navi_stream/features/home/data/data_sources/channels_remote_data_source.dart'
    as _i10;
import 'package:navi_stream/features/home/data/data_sources/packages_remote_data_source.dart'
    as _i8;
import 'package:navi_stream/features/home/data/repositories/channel_repository.dart'
    as _i11;
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart'
    as _i9;
import 'package:navi_stream/features/home/pages/cubit/home_cubit.dart' as _i12;

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
    gh.factory<_i3.AuthLocalDataSource>(() => _i3.AuthLocalDataSource());
    gh.factory<_i4.LoginRemoteDataSource>(() => _i4.LoginRemoteDataSource());
    gh.factory<_i5.LoginRepository>(() => _i5.LoginRepository(
          gh<_i4.LoginRemoteDataSource>(),
          gh<_i3.AuthLocalDataSource>(),
        ));
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i6.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.factory<_i7.LoginCubit>(
        () => _i7.LoginCubit(loginRepository: gh<_i5.LoginRepository>()));
    gh.factory<_i8.PackagesRemoteDioDataSource>(
        () => _i8.PackagesRemoteDioDataSource(gh<_i6.Dio>()));
    gh.factory<_i9.PackagesRepository>(() => _i9.PackagesRepository(
          gh<_i8.PackagesRemoteDioDataSource>(),
          gh<_i3.AuthLocalDataSource>(),
        ));
    gh.factory<_i10.ChannelsRemoteDataSource>(
        () => _i10.ChannelsRemoteDataSource(gh<_i6.Dio>()));
    gh.factory<_i11.ChannelsRepository>(() => _i11.ChannelsRepository(
          gh<_i10.ChannelsRemoteDataSource>(),
          gh<_i3.AuthLocalDataSource>(),
        ));
    gh.factory<_i12.HomeCubit>(() => _i12.HomeCubit(
          packagesRepository: gh<_i9.PackagesRepository>(),
          channelsRepository: gh<_i11.ChannelsRepository>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i13.RegisterModule {}
