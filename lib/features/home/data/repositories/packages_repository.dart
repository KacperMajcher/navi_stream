import 'package:navi_stream/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:navi_stream/features/home/data/data_sources/packages_remote_data_source.dart';
import 'package:navi_stream/features/home/data/models/package_model.dart';

class PackagesRepository {
  PackagesRepository(
    this.dataSource,
    this.localDataSource,
  );
  final PackagesRemoteDioDataSource dataSource;
  final AuthLocalDataSource localDataSource;

  Future<List<PackageModel>> fetchPackages() async {
    try {
      final token = await localDataSource.getToken();
      final ouid = await localDataSource.getOuid();
      final userId = await localDataSource.getUserId();

      final response = await dataSource.fetchPackages(
        ouid,
        userId,
        'Bearer $token',
        'Mobile',
      );

      final List<dynamic> packageList = response['data'];

      final List<PackageModel> packages =
          packageList.map((data) => PackageModel.fromJson(data)).toList();

      final List<PackageModel> purchasedPackages =
          packages.where((package) => package.purchased != null).toList();

      return purchasedPackages;
    } catch (error) {
      throw Exception(
        'Failed to fetch packages: $error',
      );
    }
  }
}
