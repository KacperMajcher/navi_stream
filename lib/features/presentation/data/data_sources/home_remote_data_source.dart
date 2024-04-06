import 'package:dio/dio.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

@RestApi()
class HomeRemoteDioDataSource {
  Future<Response<dynamic>> fetchPackages(
    String ouid,
    String userId,
    String token,
  ) async {
    try {
      final response = await Dio().get<dynamic>(
        "${apiBaseURL}v1/$ouid/users/$userId/packages",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        queryParameters: {'device_class': 'Mobile'},
      );

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access.');
      } else {
        throw Exception(
          'Error fetching data. Status code: ${response.statusCode}',
        );
      }
    } on DioException catch (error) {
      final errorMessage = error.response != null
          ? 'Error: ${error.response?.statusCode} ${error.response?.data}'
          : 'Unknown Dio error';
      throw Exception(errorMessage);
    }
  }
}
