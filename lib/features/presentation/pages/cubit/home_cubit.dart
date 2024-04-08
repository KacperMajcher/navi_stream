import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/pages/cubit/channels_cubit.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_state.dart';
import 'package:navi_stream/features/presentation/pages/cubit/packages_cubit.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.packagesCubit,
    required this.channelsCubit,
  }) : super(
          const HomeState(status: Status.loading),
        );
  final PackagesCubit packagesCubit;
  final ChannelsCubit channelsCubit;
  final storage = const FlutterSecureStorage();

  Future<void> init() async {
    final String? token = await storage.read(key: 'token');
    final String? ouid = await storage.read(key: 'ouid');
    final String? userId = await storage.read(key: 'userId');

    if (token != null && ouid != null && userId != null) {
      await packagesCubit.fetchPackages(
        ouid,
        userId,
        token,
      );
      final packageIds =
          packagesCubit.state.packages.map((package) => package.id).toList();
      await channelsCubit.getChannelModels(
        token,
        ouid,
        packageIds,
      );
      emit(HomeState(
        status: Status.success,
        channelModel: channelsCubit.state.channelModel,
      ));
    }
  }
}
