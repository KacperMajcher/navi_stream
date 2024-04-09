// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginModelImpl _$$LoginModelImplFromJson(Map<String, dynamic> json) =>
    _$LoginModelImpl(
      username: json['username'] as String,
      password: json['password'] as String,
      loginType: json['login_type'] as String,
      device: json['device'] as String,
    );

Map<String, dynamic> _$$LoginModelImplToJson(_$LoginModelImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'login_type': instance.loginType,
      'device': instance.device,
    };
