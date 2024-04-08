// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart';
import 'package:navi_stream/features/auth/presentation/widgets/login_button.dart';
import 'package:navi_stream/features/auth/presentation/widgets/login_input_field.dart';
import 'package:navi_stream/features/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;

    final loginController = TextEditingController(text: login);
    final passwordController = TextEditingController(text: password);

    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: dw * .01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginInputField(
                  controller: loginController,
                  obscureText: false,
                  hintText: 'Login',
                ),
                LoginInputField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.status == LoginStatus.success) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    } else if (state.status == LoginStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error!),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.status == LoginStatus.connecting) {
                      return const CircularProgressIndicator();
                    } else {
                      return LoginButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                                loginController.text,
                                passwordController.text,
                              );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
