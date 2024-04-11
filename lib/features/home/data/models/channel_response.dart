import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navi_stream/features/home/data/models/channel_dto.dart';

part 'channel_response.freezed.dart';
part 'channel_response.g.dart';

@freezed
class ChannelResponse with _$ChannelResponse {
  const factory ChannelResponse({
    required List<ChannelDTO> data,
  }) = _ChannelResponse;

  factory ChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelResponseFromJson(json);
}
