import 'package:get_it/get_it.dart';
import 'package:navi_stream/features/auth/data/data_source/login_data_source.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //Bloc (cubit)
  getIt.registerFactory(() => LoginCubit(loginRepository: getIt()));

  //Repository
  getIt.registerFactory(() => LoginRepository(getIt()));

  //DataSource
  getIt.registerFactory(() => LoginDataSource());
}
