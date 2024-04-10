import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/pages/cubit/channels_cubit.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_state.dart';
import 'package:navi_stream/features/presentation/pages/cubit/packages_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.packagesCubit,
    required this.channelsCubit,
  }) : super(
          const HomeState(status: Status.loading),
        );
  final PackagesCubit packagesCubit;
  final ChannelsCubit channelsCubit;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final String? ouid = prefs.getString('ouid');
    final String? userId = prefs.getString('userId');

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
