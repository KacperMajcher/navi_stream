import 'package:get_it/get_it.dart';
import 'package:navi_stream/features/auth/data/data_source/login_data_source.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:navi_stream/features/presentation/data/data_sources/channels_mocked_data_source.dart';
import 'package:navi_stream/features/presentation/data/data_sources/home_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/presentation/data/repositories/home_repository.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //Bloc (cubit)
  getIt.registerFactory(() => LoginCubit(loginRepository: getIt()));
  getIt.registerFactory(() => HomeCubit(getIt(), getIt()));

  //Repository
  getIt.registerFactory(() => LoginRepository(getIt()));
  getIt.registerFactory(() => HomeRepository(getIt()));
  getIt.registerFactory(() => ChannelsRepository(remoteDataSource: getIt()));

  //DataSource
  getIt.registerFactory(() => LoginDataSource());
  getIt.registerFactory(() => HomeRemoteDioDataSource());
  getIt.registerFactory(() => ChannelsMockedDataSource());
}
