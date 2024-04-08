part of 'home_cubit.dart';

class HomeState {
  HomeState(
    this.status, {
    this.channelModel = const [],
  });
  final Status status;
  final List<ChannelModel> channelModel;
}
