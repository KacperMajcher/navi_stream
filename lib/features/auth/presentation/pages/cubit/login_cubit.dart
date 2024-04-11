import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart';

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
        loginType: loginType,
        username: username,
        password: password,
        device: device,
      );
      await loginRepository.login(loginModel);

      emit(
        const LoginState(
          status: LoginStatus.success,
        ),
      );
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
