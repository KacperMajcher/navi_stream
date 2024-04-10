import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/models/package_model.dart';

part 'packages_state.freezed.dart';
part 'packages_state.g.dart';

@freezed
class PackagesState with _$PackagesState {
  const factory PackagesState({
    @Default(Status.loading) Status status,
    @Default([]) List<PackageModel> packages,
  }) = _PackagesState;

  factory PackagesState.fromJson(Map<String, dynamic> json) =>
      _$PackagesStateFromJson(json);
}
