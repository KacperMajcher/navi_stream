import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';
import 'package:navi_stream/features/presentation/data/repositories/channel_repository.dart';

part 'channels_state.dart';

class ChannelsCubit extends Cubit<ChannelsState> {
  final ChannelsRepository channelsRepository;

  ChannelsCubit(this.channelsRepository)
      : super(ChannelsState(
          Status.loading,
        ));

  Future<void> getChannelModels(
      String token, String ouid, List<int> packageIds) async {
    final channelModel = await channelsRepository.getChannelModels(
      token: token,
      ouid: ouid,
      packageIds: packageIds,
    );
    emit(ChannelsState(
      Status.success,
      channelModel: channelModel,
    ));
  }
}
