import 'package:navi_stream/features/auth/data/data_source/login_data_source.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';

class LoginRepository {
  final LoginDataSource dataSource;

  LoginRepository(this.dataSource);

  Future<LoginResponse?> login(LoginModel loginModel) async {
    return await dataSource.login(loginModel);
  }
}
