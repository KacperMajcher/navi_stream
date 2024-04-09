import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';

@injectable
class LoginDataSource {
  Future<Response> login(LoginModel loginModel) async {
    const url = apiBaseURL + endpointLogin;

    final response = await Dio().post(
      url,
      data: loginModel.toJson(),
    );
    return response;
  }
}
