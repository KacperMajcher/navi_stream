import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit({required this.loginRepository})
      : super(
          LoginState(status: LoginStatus.initial),
        );

  void login(String username, String password) async {
    emit(
      LoginState(
        status: LoginStatus.connecting,
      ),
    );
    try {
      final token = await loginRepository.login(
        LoginModel(
          username: username,
          password: password,
        ),
      );
      emit(
        LoginState(
          status: LoginStatus.success,
          token: token,
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
