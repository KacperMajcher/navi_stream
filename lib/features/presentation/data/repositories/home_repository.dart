import 'package:dio/dio.dart';
import 'package:navi_stream/features/presentation/data/data_sources/home_remote_data_source.dart';

class HomeRepository {
  final HomeRemoteDioDataSource dataSource;

  HomeRepository(this.dataSource);

  Future<Response<dynamic>> fetchPackages(
    String ouid,
    String userId,
    String token,
  ) async {
    return await dataSource.fetchPackages(
      ouid,
      userId,
      token,
    );
  }
}
