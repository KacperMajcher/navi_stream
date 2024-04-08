import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

part 'channels_state.freezed.dart';
part 'channels_state.g.dart';

@freezed
class ChannelsState with _$ChannelsState {
  const factory ChannelsState({
    @Default(Status.loading) Status status,
    @Default([]) List<ChannelModel> channelModel,
  }) = _ChannelsState;

  factory ChannelsState.fromJson(Map<String, dynamic> json) => _$ChannelsStateFromJson(json);
}
