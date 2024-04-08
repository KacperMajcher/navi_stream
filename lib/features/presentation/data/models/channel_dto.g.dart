// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelDTO _$ChannelDTOFromJson(Map<String, dynamic> json) => ChannelDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      logos: json['logos'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ChannelDTOToJson(ChannelDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logos': instance.logos,
    };
