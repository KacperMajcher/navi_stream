// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelModelImpl _$$ChannelModelImplFromJson(Map<String, dynamic> json) =>
    _$ChannelModelImpl(
      channelName: json['channelName'] as String,
      logoId: json['logoId'] as int?,
      channelLogo: json['channelLogo'] as String,
    );

Map<String, dynamic> _$$ChannelModelImplToJson(_$ChannelModelImpl instance) =>
    <String, dynamic>{
      'channelName': instance.channelName,
      'logoId': instance.logoId,
      'channelLogo': instance.channelLogo,
    };
