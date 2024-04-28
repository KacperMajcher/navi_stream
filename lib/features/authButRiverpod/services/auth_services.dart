import 'package:dio/dio.dart';
import 'package:navi_stream/features/authButRiverpod/models/login_model.dart';
import 'package:navi_stream/features/authButRiverpod/services/storage_service.dart';

import 'api_services.dart';

class AuthServices {
  final ApiServices _apiServices;
  final StorageService _storageService;

  AuthServices(this._apiServices, this._storageService);

  Future<bool> login(LoginModel model) async {
    try {
      final response = await _apiServices.login(model);

      if (response.statusCode == 200) {
        _storageService.setToken(response);
        _storageService.setOuid(response);
        _storageService.setUserId(response);

        return true;
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
