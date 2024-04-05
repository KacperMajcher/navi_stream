import 'package:dio/dio.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataSource {
  Future<String> login(LoginModel loginModel) async {
    const url = apiBaseURL + endpointLogin;
    try {
      final response = await Dio().post(
        url,
        data: loginModel.toJson(),
      );
      if (response.statusCode == 200) {
        final token = response.data['data']['access_token'];
        if (token != null) {
          // make sure that oken is available
          await _saveToken(token);
          await _saveUsername(loginModel.username);
          return token;
        } else {
          throw Exception(
            'Token not found in the response',
          );
        }
      } else {
        throw Exception(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      throw Exception(
        'Request failed: ${dioError.message}',
      );
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<void> _saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }
}
