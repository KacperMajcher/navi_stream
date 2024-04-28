import 'package:dio/dio.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/authButRiverpod/models/login_model.dart';

class ApiServices {
  Future<Response> login(LoginModel loginModel) async {
    const url = apiBaseURL + endpointLogin;
    try {
      final response = await Dio().post(
        url,
        data: loginModel.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(
        'Failed to login: ${e.response?.statusMessage}',
      );
    }
  }
}
