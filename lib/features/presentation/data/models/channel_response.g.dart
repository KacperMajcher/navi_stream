// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelResponseImpl _$$ChannelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChannelResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChannelDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChannelResponseImplToJson(
        _$ChannelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
