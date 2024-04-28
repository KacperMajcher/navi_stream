// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navi_stream/features/authButRiverpod/handlers/login_handler.dart';
import 'package:navi_stream/features/authButRiverpod/pages/password_recovery_page.dart';
import 'package:navi_stream/features/authButRiverpod/widgets/custom_button.dart';
import 'package:navi_stream/features/authButRiverpod/widgets/login_input_field.dart';
import 'package:navi_stream/features/home/pages/home_page.dart';
import 'package:navi_stream/utils/custom_app_bar.dart';
import 'package:navi_stream/utils/text_suffix.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double dw = MediaQuery.of(context).size.width;
    final double dh = MediaQuery.of(context).size.height;

    final loginHandler = LoginHandler(ref);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dw * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: dh * .08),
            Center(
              child: Text(
                'Login',
                style: suffix(
                  dh * .04,
                  Colors.black,
                  FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: dh * .04),
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
            SizedBox(height: dh * .008),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PasswordRecoveryPage(),
                ),
              ),
              child: Text(
                'Forgot your password?',
                style: suffix(
                  dh * .015,
                  Colors.black,
                  FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: dh * .04),
            Center(
              child: CustomButton(
                color: const Color(0xFF837ADD),
                text: 'Log In',
                onPressed: () async {
                  try {
                    await loginHandler.handleLogin(
                      loginController.text,
                      passwordController.text,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: dh * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account? ",
                  style: suffix(
                    dh * .014,
                    Colors.grey,
                    FontWeight.normal,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PasswordRecoveryPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Create now",
                    style: suffix(
                      dh * .014,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
