// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginStateImpl _$$LoginStateImplFromJson(Map<String, dynamic> json) =>
    _$LoginStateImpl(
      status: $enumDecodeNullable(_$LoginStatusEnumMap, json['status']) ??
          LoginStatus.initial,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$LoginStateImplToJson(_$LoginStateImpl instance) =>
    <String, dynamic>{
      'status': _$LoginStatusEnumMap[instance.status]!,
      'error': instance.error,
    };

const _$LoginStatusEnumMap = {
  LoginStatus.initial: 'initial',
  LoginStatus.connecting: 'connecting',
  LoginStatus.success: 'success',
  LoginStatus.error: 'error',
  LoginStatus.firstLogin: 'firstLogin',
};
