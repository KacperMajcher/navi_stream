import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';
import 'package:navi_stream/features/presentation/pages/cubit/channels_cubit.dart';
import 'package:navi_stream/features/presentation/pages/cubit/packages_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PackagesCubit packagesCubit;
  final ChannelsCubit channelsCubit;
  final storage = const FlutterSecureStorage();

  HomeCubit(this.packagesCubit, this.channelsCubit)
      : super(
          HomeState(Status.loading),
        );

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
        Status.success,
        channelModel: channelsCubit.state.channelModel,
      ));
    }
  }
}
