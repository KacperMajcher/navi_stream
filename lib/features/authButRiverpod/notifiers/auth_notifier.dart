import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navi_stream/features/authButRiverpod/models/login_model.dart';
import 'package:navi_stream/features/authButRiverpod/services/auth_services.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthServices _authServices;

  AuthNotifier(this._authServices) : super(false);

  Future<bool> login(LoginModel loginModel) async {
    state = true;
    bool loginSuccess = false;
    try {
      loginSuccess = await _authServices.login(loginModel);
      loginSuccess = true;
    } catch (e) {
      loginSuccess = false;
    }
    return loginSuccess;
  }
}
