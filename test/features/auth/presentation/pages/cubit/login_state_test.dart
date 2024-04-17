import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart';

void main() {
  group(
    'LoginState tests',
    () {
      group(
        'serialization',
        () {
          const loginState = LoginState(
            status: LoginStatus.success,
            error: 'error',
          );
          final json = loginState.toJson();
          final expectedJson = {
            'status': 'success',
            'error': 'error',
          };

          test(
            'should serialize to JSON correctly',
            () {
              expect(json, expectedJson);
            },
          );

          test(
            'should deserialize from JSON correctly',
            () {
              final parsedLoginState = LoginState.fromJson(
                json,
              );
              expect(parsedLoginState, loginState);
            },
          );
        },
      );
    },
  );
}
