import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';

void main() {
  group(
    'LoginModel tests',
    () {
      const loginModel = LoginModel(
        username: 'testUser',
        password: 'testPass',
        loginType: 'testLoginType',
        device: 'testDevice',
      );

      const json = {
        'username': 'testUser',
        'password': 'testPass',
        'login_type': 'testLoginType',
        'device': 'testDevice',
      };

      group(
        'instantiation test',
        () {
          test(
            'should correctly instantiate from values',
            () {
              expect(loginModel.username, 'testUser');
              expect(loginModel.password, 'testPass');
              expect(loginModel.loginType, 'testLoginType');
              expect(loginModel.device, 'testDevice');
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
              final result = loginModel.toJson();

              expect(result, json);
            },
          );

          test(
            'should deserialize from JSON',
            () {
              final result = LoginModel.fromJson(json);

              expect(result, loginModel);
            },
          );
        },
      );
    },
  );
}
