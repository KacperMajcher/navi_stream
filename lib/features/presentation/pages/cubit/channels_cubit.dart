import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/repositories/channel_repository.dart';
import 'channels_state.dart';

class ChannelsCubit extends Cubit<ChannelsState> {
  final ChannelsRepository channelsRepository;

  ChannelsCubit(this.channelsRepository)
      : super(const ChannelsState(
          status: Status.loading,
        ));

  Future<void> getChannelModels(
      String token, String ouid, List<int> packageIds) async {
    try {
      final channelModel = await channelsRepository.getChannelModels(
        token: token,
        ouid: ouid,
        packageIds: packageIds,
      );
      emit(
        ChannelsState(
          status: Status.success,
          channelModel: channelModel,
        )
      );
    } catch (_) {
      emit(
        const ChannelsState(status: Status.error),
      );
    }
  }
}
