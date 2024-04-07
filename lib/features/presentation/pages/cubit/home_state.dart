part of 'home_cubit.dart';

class HomeState {
  HomeState({
    this.ouid,
    this.userId,
    this.token,
    this.packages = const [],
  });

  final String? ouid;
  final String? userId;
  final String? token;
  List<Package> packages;

  final String channelName = 'Canal+ Cinema';
  final String channelLogo = 'assets/logo_test.jpg';

  void updatePackages(List<Package> newPackages) {
    packages = newPackages;
  }
}
