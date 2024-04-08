// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channels_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelsStateImpl _$$ChannelsStateImplFromJson(Map<String, dynamic> json) =>
    _$ChannelsStateImpl(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.loading,
      channelModel: (json['channelModel'] as List<dynamic>?)
              ?.map((e) => ChannelModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ChannelsStateImplToJson(_$ChannelsStateImpl instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'channelModel': instance.channelModel,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.loading: 'loading',
  Status.success: 'success',
  Status.error: 'error',
};
