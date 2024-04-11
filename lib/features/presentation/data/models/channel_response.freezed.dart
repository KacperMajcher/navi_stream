// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChannelResponse _$ChannelResponseFromJson(Map<String, dynamic> json) {
  return _ChannelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChannelResponse {
  List<ChannelDTO> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelResponseCopyWith<ChannelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelResponseCopyWith<$Res> {
  factory $ChannelResponseCopyWith(
          ChannelResponse value, $Res Function(ChannelResponse) then) =
      _$ChannelResponseCopyWithImpl<$Res, ChannelResponse>;
  @useResult
  $Res call({List<ChannelDTO> data});
}

/// @nodoc
class _$ChannelResponseCopyWithImpl<$Res, $Val extends ChannelResponse>
    implements $ChannelResponseCopyWith<$Res> {
  _$ChannelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChannelResponseImplCopyWith<$Res>
    implements $ChannelResponseCopyWith<$Res> {
  factory _$$ChannelResponseImplCopyWith(_$ChannelResponseImpl value,
          $Res Function(_$ChannelResponseImpl) then) =
      __$$ChannelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChannelDTO> data});
}

/// @nodoc
class __$$ChannelResponseImplCopyWithImpl<$Res>
    extends _$ChannelResponseCopyWithImpl<$Res, _$ChannelResponseImpl>
    implements _$$ChannelResponseImplCopyWith<$Res> {
  __$$ChannelResponseImplCopyWithImpl(
      _$ChannelResponseImpl _value, $Res Function(_$ChannelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ChannelResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelResponseImpl implements _ChannelResponse {
  const _$ChannelResponseImpl({required final List<ChannelDTO> data})
      : _data = data;

  factory _$ChannelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelResponseImplFromJson(json);

  final List<ChannelDTO> _data;
  @override
  List<ChannelDTO> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ChannelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelResponseImplCopyWith<_$ChannelResponseImpl> get copyWith =>
      __$$ChannelResponseImplCopyWithImpl<_$ChannelResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChannelResponse implements ChannelResponse {
  const factory _ChannelResponse({required final List<ChannelDTO> data}) =
      _$ChannelResponseImpl;

  factory _ChannelResponse.fromJson(Map<String, dynamic> json) =
      _$ChannelResponseImpl.fromJson;

  @override
  List<ChannelDTO> get data;
  @override
  @JsonKey(ignore: true)
  _$$ChannelResponseImplCopyWith<_$ChannelResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
