// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PackagesStateImpl _$$PackagesStateImplFromJson(Map<String, dynamic> json) =>
    _$PackagesStateImpl(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.loading,
      packages: (json['packages'] as List<dynamic>?)
              ?.map((e) => PackageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PackagesStateImplToJson(_$PackagesStateImpl instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'packages': instance.packages,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.loading: 'loading',
  Status.success: 'success',
  Status.error: 'error',
};
