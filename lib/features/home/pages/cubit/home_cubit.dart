import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';
import 'package:navi_stream/features/home/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart';
import 'package:navi_stream/features/home/pages/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PackagesRepository packagesRepository;
  final ChannelsRepository channelsRepository;
  List<ChannelModel> _allChannels = [];

  HomeCubit({
    required this.packagesRepository,
    required this.channelsRepository,
  }) : super(
          const HomeState(
            status: Status.loading,
          ),
        );

  Future<void> init() async {
    try {
      final packages = await packagesRepository.fetchPackages();
      final packageIds = packages.map((package) => package.id).toList();
      _allChannels = await channelsRepository.getChannelModels(
        packageIds: packageIds,
      );
      emit(
        HomeState(
          status: Status.success,
          channelModel: _allChannels,
        ),
      );
    } catch (e) {
      emit(
        const HomeState(
          status: Status.error,
        ),
      );
    }
  }

  void filterChannels(String value) {
    if (value.isEmpty) {
      emit(
        HomeState(
          status: Status.success,
          channelModel: _allChannels,
        ),
      );
    } else {
      final filteredChannels = _allChannels
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
