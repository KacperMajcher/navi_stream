import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart'; // Adjust the import path

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  group(
    'LoginState tests',
    () {
      final repository = MockLoginRepository();

      test(
        'initial state is LoginState.initial',
        () {
          final loginCubit = LoginCubit(
            loginRepository: repository,
          );
          expect(
            loginCubit.state,
            const LoginState(
              status: LoginStatus.initial,
            ),
          );
        },
      );
    },
  );
}
