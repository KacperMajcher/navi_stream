import 'package:get_it/get_it.dart';
import 'package:navi_stream/features/auth/data/data_source/login_data_source.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:navi_stream/features/presentation/data/data_sources/channels_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/data_sources/packages_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/presentation/data/repositories/packages_repository.dart';
import 'package:navi_stream/features/presentation/pages/cubit/channels_cubit.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_cubit.dart';
import 'package:navi_stream/features/presentation/pages/cubit/packages_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //Bloc (cubit)
  getIt.registerFactory(() => LoginCubit(loginRepository: getIt()));
  getIt.registerFactory(
      () => HomeCubit(PackagesCubit(getIt()), ChannelsCubit(getIt())));
  getIt.registerFactory(() => ChannelsCubit(getIt()));
  getIt.registerFactory(() => PackagesCubit(getIt()));

  //Repository
  getIt.registerFactory(() => LoginRepository(getIt()));
  getIt.registerFactory(() => PackagesRepository(getIt()));
  getIt.registerFactory(() => ChannelsRepository(remoteDataSource: getIt()));

  //DataSource
  getIt.registerFactory(() => LoginDataSource());
  getIt.registerFactory(() => PackagesRemoteDioDataSource());
  getIt.registerFactory(() => ChannelsRemoteDataSource());

}
