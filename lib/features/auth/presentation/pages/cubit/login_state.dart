part of 'login_cubit.dart';

class LoginState {
  LoginState({
    required this.status,
    this.error = '',
  });

  final LoginStatus status;
  final String error;
}
