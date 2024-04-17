import 'package:dio/dio.dart';
import 'package:navi_stream/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:navi_stream/features/auth/data/data_source/login_remote_data_source.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';

class LoginRepository {
  LoginRepository(
    this.dataSource,
    this.localDataSource,
  );

  final LoginRemoteDataSource dataSource;
  final AuthLocalDataSource localDataSource;

  Future<Response> login(LoginModel loginModel) async {
    try {
      final response = await dataSource.login(loginModel);

      if (response.statusCode == 200) {
        localDataSource.setToken(response);
        localDataSource.setOuid(response);
        localDataSource.setUserId(response);

        return response;
      } else if (response.statusCode == 401) {
        throw Exception(
          'Unauthorized access.',
        );
      } else {
        throw Exception(
          'Error fetching data. Status code: ${response.statusCode}',
        );
      }
    } on DioException catch (error) {
      final errorMessage = error.response != null
          ? 'Error: ${error.response?.statusCode} ${error.response?.data}'
          : 'Unknown Dio error';
      throw Exception(
        errorMessage,
      );
    } catch (error) {
      throw Exception(
        'Error during login: $error',
      );
    }
  }
}
