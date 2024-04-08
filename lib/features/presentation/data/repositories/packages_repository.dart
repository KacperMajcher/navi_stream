import 'package:dio/dio.dart';
import 'package:navi_stream/features/presentation/data/data_sources/packages_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/models/package_model.dart';

class PackagesRepository {
  final PackagesRemoteDioDataSource dataSource;

  PackagesRepository(this.dataSource);

  Future<List<PackageModel>> fetchPackages(
    String ouid,
    String userId,
    String token,
  ) async {
    try {
      Response<dynamic> response = await dataSource.fetchPackages(
        ouid,
        userId,
        token,
      );

      if (response.statusCode == 200) {
        // get data
        final List<dynamic> packageList = response.data['data'];

        // transfrom json list into models
        final List<PackageModel> packages =
            packageList.map((data) => PackageModel.fromJson(data)).toList();

        // filter packages, we dont need non purchased packages
        final List<PackageModel> purchasedPackages =
            packages.where((package) => package.purchased != null).toList();
        return purchasedPackages;
      } else {
        throw Exception('Failed to fetch packages');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
