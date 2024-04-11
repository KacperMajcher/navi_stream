import 'package:dio/dio.dart';
import 'package:navi_stream/features/auth/data/data_source/login_remote_data_source.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  LoginRepository(
    this.dataSource,
  );

  final LoginRemoteDataSource dataSource;

  Future<LoginResponse> login(LoginModel loginModel) async {
    try {
      final response = await dataSource.login(loginModel);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['data']['access_token']);
        prefs.setString('ouid', response.data['data']['operator_uid']);
        prefs.setInt('userId', response.data['data']['user_id']);

        // save necessary data for displaying channels
        return LoginResponse(
          token: response.data['data']['access_token'],
          ouid: response.data['data']['operator_uid'],
          userId: response.data['data']['user_id'],
        );
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access.');
      } else {
        throw Exception(
            'Error fetching data. Status code: ${response.statusCode}');
      }
    } on DioException catch (error) {
      final errorMessage = error.response != null
          ? 'Error: ${error.response?.statusCode} ${error.response?.data}'
          : 'Unknown Dio error';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}
