import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/authButRiverpod/models/login_model.dart';
import 'package:navi_stream/features/authButRiverpod/providers/providers.dart';

class LoginHandler {
  final WidgetRef ref;

  LoginHandler(this.ref);

  Future<void> handleLogin(String username, String password) async {
    final loginModel = LoginModel(
      username: username,
      password: password,
      loginType: loginType,
      device: device,
    );

    final loginSuccess =
        await ref.read(authNotifierProvider.notifier).login(loginModel);

    if (!loginSuccess) {
      throw Exception(
        'Login failed. Please try again.',
      );
    }
  }
}
