import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/presentation/data/repositories/packages_repository.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.packagesRepository,
    required this.channelsRepository,
  }) : super(
          const HomeState(status: Status.loading),
        );
  final PackagesRepository packagesRepository;
  final ChannelsRepository channelsRepository;

  Future<void> init() async {
    final packages = await packagesRepository.fetchPackages();

    final packageIds = packages.map((package) => package.id).toList();

    final channelModel = await channelsRepository.getChannelModels(
      packageIds: packageIds,
    );
    emit(
      HomeState(
        status: Status.success,
        channelModel: channelModel,
      ),
    );
  }

  void filterChannels(String value) {
    if (value.isEmpty) {
      emit(
        HomeState(
          status: Status.success,
          channelModel: channelsCubit.state.channelModel,
        ),
      );
    } else {
      final filteredChannels = channelsCubit.state.channelModel
          .where((channel) =>
              channel.channelName.toLowerCase().contains(value.toLowerCase()))
          .toList();
      emit(
        HomeState(
          status: Status.success,
          channelModel: filteredChannels,
        ),
      );
    }
  }
}
