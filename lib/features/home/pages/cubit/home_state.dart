import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(Status.loading) Status status,
    @Default([]) List<ChannelModel> channelModel,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);
}
