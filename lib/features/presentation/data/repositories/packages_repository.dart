import 'package:navi_stream/features/presentation/data/data_sources/packages_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/models/package_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackagesRepository {
  PackagesRepository(
    this.dataSource,
  );
  final PackagesRemoteDioDataSource dataSource;

  Future<List<PackageModel>> fetchPackages() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token')!;
      final String ouid = prefs.getString('ouid')!;
      final int userId = prefs.getInt('userId')!;

      final response = await dataSource.fetchPackages(
        ouid,
        userId,
        'Bearer $token',
        'Mobile',
      );

      // response is already the JSON body here
      final List<dynamic> packageList = response['data'];

      // transfrom json list into models
      final List<PackageModel> packages =
          packageList.map((data) => PackageModel.fromJson(data)).toList();

      // filter packages, we dont need non purchased packages
      final List<PackageModel> purchasedPackages =
          packages.where((package) => package.purchased != null).toList();

      return purchasedPackages;
    } catch (e) {
      throw Exception('Failed to fetch packages: $e');
    }
  }
}
