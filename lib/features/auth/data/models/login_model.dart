import 'package:navi_stream/core/constants/constants.dart';

class LoginModel {
  LoginModel({
    required this.username,
    required this.password,
  });
  final String username;
  final String password;

  Map<String, dynamic> toJson() => {
        "login_type": "Credentials",
        "username": username,
        "password": password,
        "device": "flutter_test_device_${devName}_$devSurname"
      };
}
