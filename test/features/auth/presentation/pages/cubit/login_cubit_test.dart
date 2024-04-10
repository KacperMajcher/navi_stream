import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const LoginModel(
        username: 'username',
        password: 'password',
        loginType: 'loginType',
        device: 'device',
      ),
    );
  });

  group('LoginCubit tests', () {
    late MockLoginRepository repository;
    late LoginCubit sut;

    setUp(() {
      repository = MockLoginRepository();
      sut = LoginCubit(loginRepository: repository);
    });
    group('login success', () {
      blocTest<LoginCubit, LoginState>(
        'emits status connecting then success',
        build: () {
          when(() => repository.login(any())).thenAnswer(
            (_) async => const LoginResponse(
              ouid: 'ouid',
              userId: 222,
              token: 'token',
            ),
          );
          return sut;
        },
        act: (cubit) => cubit.login('username', 'password'),
        expect: () => [
          const LoginState(status: LoginStatus.connecting),
          const LoginState(status: LoginStatus.success),
        ],
      );
    });

    group('login failure', () {
      blocTest<LoginCubit, LoginState>(
        'emits status connecting then error on failure',
        build: () {
          when(() => repository.login(any())).thenThrow(
            Exception(
              'Login failed',
            ),
          );
          return sut;
        },
        act: (cubit) => cubit.login(
          'username',
          'password',
        ),
        expect: () => [
          const LoginState(
            status: LoginStatus.connecting,
          ),
          const LoginState(
            status: LoginStatus.error,
            error: 'Exception: Login failed',
          ),
        ],
      );
    });
  });
}
