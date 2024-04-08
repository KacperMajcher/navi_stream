// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';

class LoginDataSource {
  Future<LoginResponse?> login(LoginModel loginModel) async {
    const url = apiBaseURL + endpointLogin;
    try {
      final response = await Dio().post(
        url,
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200) {
        final token = response.data['data']['access_token'];
        final ouid = response.data['data']['operator_uid'];
        final userId = response.data['data']['user_id'];

        if (token != null) {
          // save necessary data for displaying channels
          return LoginResponse(
            token,
            ouid,
            userId.toString(),
          );

          // handle dio errors
        } else if (response.statusCode == 401) {
          throw Exception('Unauthorized access.');
        } else {
          throw Exception(
              'Error fetching data. Status code: ${response.statusCode}');
        }
      }
    } on DioException catch (error) {
      final errorMessage = error.response != null
          ? 'Error: ${error.response?.statusCode} ${error.response?.data}'
          : 'Unknown Dio error';
      throw Exception(errorMessage);
    }
    return null;
  }
}
