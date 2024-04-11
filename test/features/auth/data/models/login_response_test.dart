import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/features/auth/data/models/login_response.dart';

void main() {
  group(
    'LoginResponse tests',
    () {
      const loginResponse = LoginResponse(
        token: 'token',
        ouid: 'ouid',
        userId: 222,
      );

      final Map<String, dynamic> json = {
        'token': 'token',
        'ouid': 'ouid',
        'user_id': 222,
      };

      group(
        'instantiation test',
        () {
          test(
            'should correctly instantiate from values',
            () {
              expect(loginResponse.token, 'token');
              expect(loginResponse.ouid, 'ouid');
              expect(loginResponse.userId, 222);
            },
          );
        },
      );

      group(
        'serialization tests',
        () {
          test(
            'should serialize to JSON',
            () {
              final result = loginResponse.toJson();

              expect(result, json);
            },
          );
          test(
            'should deserialize from JSON',
            () {
              final result = LoginResponse.fromJson(json);

              expect(result, loginResponse);
            },
          );
        },
      );
    },
  );
}
