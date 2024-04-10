// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'packages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PackagesState _$PackagesStateFromJson(Map<String, dynamic> json) {
  return _PackagesState.fromJson(json);
}

/// @nodoc
mixin _$PackagesState {
  Status get status => throw _privateConstructorUsedError;
  List<PackageModel> get packages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackagesStateCopyWith<PackagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackagesStateCopyWith<$Res> {
  factory $PackagesStateCopyWith(
          PackagesState value, $Res Function(PackagesState) then) =
      _$PackagesStateCopyWithImpl<$Res, PackagesState>;
  @useResult
  $Res call({Status status, List<PackageModel> packages});
}

/// @nodoc
class _$PackagesStateCopyWithImpl<$Res, $Val extends PackagesState>
    implements $PackagesStateCopyWith<$Res> {
  _$PackagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? packages = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      packages: null == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<PackageModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PackagesStateImplCopyWith<$Res>
    implements $PackagesStateCopyWith<$Res> {
  factory _$$PackagesStateImplCopyWith(
          _$PackagesStateImpl value, $Res Function(_$PackagesStateImpl) then) =
      __$$PackagesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status, List<PackageModel> packages});
}

/// @nodoc
class __$$PackagesStateImplCopyWithImpl<$Res>
    extends _$PackagesStateCopyWithImpl<$Res, _$PackagesStateImpl>
    implements _$$PackagesStateImplCopyWith<$Res> {
  __$$PackagesStateImplCopyWithImpl(
      _$PackagesStateImpl _value, $Res Function(_$PackagesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? packages = null,
  }) {
    return _then(_$PackagesStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      packages: null == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<PackageModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackagesStateImpl implements _PackagesState {
  const _$PackagesStateImpl(
      {this.status = Status.loading,
      final List<PackageModel> packages = const []})
      : _packages = packages;

  factory _$PackagesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackagesStateImplFromJson(json);

  @override
  @JsonKey()
  final Status status;
  final List<PackageModel> _packages;
  @override
  @JsonKey()
  List<PackageModel> get packages {
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packages);
  }

  @override
  String toString() {
    return 'PackagesState(status: $status, packages: $packages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackagesStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._packages, _packages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_packages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PackagesStateImplCopyWith<_$PackagesStateImpl> get copyWith =>
      __$$PackagesStateImplCopyWithImpl<_$PackagesStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackagesStateImplToJson(
      this,
    );
  }
}

abstract class _PackagesState implements PackagesState {
  const factory _PackagesState(
      {final Status status,
      final List<PackageModel> packages}) = _$PackagesStateImpl;

  factory _PackagesState.fromJson(Map<String, dynamic> json) =
      _$PackagesStateImpl.fromJson;

  @override
  Status get status;
  @override
  List<PackageModel> get packages;
  @override
  @JsonKey(ignore: true)
  _$$PackagesStateImplCopyWith<_$PackagesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
