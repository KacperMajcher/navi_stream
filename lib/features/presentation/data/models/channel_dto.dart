import 'package:json_annotation/json_annotation.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

part 'channel_dto.g.dart';

@JsonSerializable()
class ChannelDTO {
  final int id;
  final String name;
  final Map<String, dynamic>? logos;

  ChannelDTO({
    required this.id,
    required this.name,
    this.logos,
  });

  factory ChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelDTOToJson(this);

  // convert DTO
  ChannelModel toDomain() {
    // if there is at least one element, find it - this will be our logo
    final int? cardLogoId = logos != null
        ? (logos!['NORMAL'] ??
            logos!['CARD'] ??
            logos!['SHADOW'] ??
            logos!['LEGACY'])
        : null;
    return ChannelModel(
      channelName: name,
      logoId: cardLogoId,
      channelLogo: cardLogoId != null
          ? '${apiBaseURL}v1/global/images/$cardLogoId?$logoAccessKey'
          : '${apiBaseURL}v1/global/images/5638?$logoAccessKey', // default image path
    );
  }
}
