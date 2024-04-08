import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit({
    required this.loginRepository,
  }) : super(
          LoginState(
            status: LoginStatus.initial,
          ),
        );

  Future<void> login(String username, String password) async {
    emit(
      LoginState(
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
        saveToStorage(
          response.ouid,
          response.userId,
          response.token,
        );
        emit(
          LoginState(
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
  const storage = FlutterSecureStorage();
  await storage.write(key: 'ouid', value: ouid);
  await storage.write(key: 'userId', value: userId);
  await storage.write(key: 'token', value: token);
}
