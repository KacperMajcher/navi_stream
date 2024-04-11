import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'packages_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class PackagesRemoteDioDataSource {
  @factoryMethod
  factory PackagesRemoteDioDataSource(Dio dio) = _PackagesRemoteDioDataSource;

  @GET('v1/{ouid}/users/{userId}/packages')
  Future<dynamic> fetchPackages(
    @Path("ouid") String ouid,
    @Path("userId") int userId,
    @Header("Authorization") String token,
    @Query("device_class") String deviceClass,
  );
}