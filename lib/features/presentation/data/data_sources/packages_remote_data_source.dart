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
    @Path("userId") String userId,
    @Header("Authorization") String token,
    @Query("device_class") String deviceClass,
  );
}

// class PackagesRemoteDioDataSource {
//   Future<Response<dynamic>> fetchPackages(
//       String ouid, String userId, String token) async {
//     try {
//       final response = await Dio().get<dynamic>(
//         "${apiBaseURL}v1/$ouid/users/$userId/packages",
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//         queryParameters: {'device_class': 'Mobile'},
//       );

//       if (response.statusCode == 200) {
//         return response;
//       } else if (response.statusCode == 401) {
//         throw Exception('Unauthorized access.');
//       } else {
//         throw Exception(
//           'Error fetching data. Status code: ${response.statusCode}',
//         );
//       }
//     } on DioException catch (error) {
//       final errorMessage = error.response != null
//           ? 'Error: ${error.response?.statusCode} ${error.response?.data}'
//           : 'Unknown Dio error';
//       throw Exception(errorMessage);
//     }
//   }
// }
