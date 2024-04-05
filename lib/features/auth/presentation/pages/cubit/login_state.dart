part of 'login_cubit.dart';

class LoginState {
  LoginState({
    required this.status,
    this.token = '',
    this.error = '',
  });
  final LoginStatus status;
  final String token;
  final String error;
}
