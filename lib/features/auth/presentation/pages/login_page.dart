import 'package:flutter/material.dart';
import 'package:navi_stream/features/auth/presentation/widgets/login_button.dart';
import 'package:navi_stream/features/auth/presentation/widgets/login_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;

    final loginController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
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
              const LoginButton()
            ],
          ),
        ),
      ),
    );
  }
}
