part of 'channels_cubit.dart';

class ChannelsState {
  ChannelsState(
    this.status, {
    this.channelModel = const [],
  });
  final List<ChannelModel> channelModel;
  final Status status;
}
