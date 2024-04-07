import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/presentation/pages/cubit/home_cubit.dart';

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
        emit(
          LoginState(
            status: LoginStatus.success,
          ),
        );
        getIt<HomeCubit>().update(
          response.ouid,
          response.userId,
          response.token,
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
