part of 'packages_cubit.dart';

class PackagesState {
  PackagesState(
    this.status, {
    this.packages = const [],
  });
  final List<Package> packages;
  final Status status;
}
