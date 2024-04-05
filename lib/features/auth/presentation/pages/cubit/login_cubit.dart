// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(
          LoginState(
            status: LoginStatus.initial,
            token: '',
            error: '',
          ),
        );

  void login(String username, String password) async {
    emit(
      LoginState(
        status: LoginStatus.connecting,
        token: '',
        error: '',
      ),
    );

    const url = apiBaseURL + endpointLogin;
    const uid = "flutter_test_device_${devName}_$devSurname";
    
    final Map<String, dynamic> data = {
      "login_type": "Credentials",
      "username": username,
      "password": password,
      "device": uid,
    };

    try {
      final response = await Dio().post(url, data: data);

      // code 200
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = response.data['data']['access_token'];

        if (token != null) {
          // save token
          await prefs.setString('access_token', token);
        } else {
          // Make sure that token is available
          String errorMessage = response.data['data']['access_token'] == null
              ? 'Token not found in response'
              : 'Login failed. Status code: ${response.statusCode}';
          emit(
            LoginState(
              status: LoginStatus.error,
              token: '',
              error: errorMessage,
            ),
          );
        }
        // save username
        await prefs.setString('username', username);

        emit(
          LoginState(
            status: LoginStatus.success,
            token: response.data['data']['access_token'],
            error: '',
          ),
        );
      } else {
        emit(
          LoginState(
            status: LoginStatus.error,
            token: '',
            error: 'Login failed',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginState(
          status: LoginStatus.error,
          token: '',
          error: 'Request failed: $e',
        ),
      );
    }
  }
}
