import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit({
    required this.loginRepository,
  }) : super(
          const LoginState(
            status: LoginStatus.initial,
          ),
        );

  Future<void> login(String username, String password) async {
    emit(
      const LoginState(
        status: LoginStatus.connecting,
      ),
    );
    try {
      final loginModel = LoginModel(
        username: username,
        password: password,
      );
      final LoginResponse? response = await loginRepository.login(loginModel);

      if (response != null) {
        await saveToStorage(
          response.ouid,
          response.userId,
          response.token,
        );
        emit(
          const LoginState(
            status: LoginStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        LoginState(
          status: LoginStatus.error,
          error: e.toString(),
        ),
      );
    }
  }
}

Future<void> saveToStorage(String ouid, String userId, String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('ouid', ouid);
  await prefs.setString('userId', userId);
  await prefs.setString('token', token);
}