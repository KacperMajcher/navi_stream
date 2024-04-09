import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navi_stream/app/injection_container.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_cubit.dart';
import 'package:navi_stream/features/auth/presentation/pages/cubit/login_state.dart';
import 'package:navi_stream/features/auth/presentation/widgets/custom_button.dart';
import 'package:navi_stream/features/auth/presentation/widgets/login_input_field.dart';
import 'package:navi_stream/features/presentation/pages/home_page.dart';
import 'package:navi_stream/features/widgets/custom_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String providedLogin = '';
  String providedPassword = '';

  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();

    loginController.addListener(() {
      activateLoginButton();
    });
    passwordController.addListener(() {
      activateLoginButton();
    });

    activateLoginButton(); // initial activation check
  }

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    final double dh = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
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
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: dh * .04, fontWeight: FontWeight.w800),
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
                  Text(
                    'Forgot your password?',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: dh * .015, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: dh * .04),
                  BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                    if (state.status == LoginStatus.success) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    } else if (state.status == LoginStatus.error) {
                      final errorMessage = state.error ?? 'Unkown error';

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            errorMessage ==
                                    'Exception: Error: 400 {code: 3009, status: error, data: {message: Invalid Credentials}}'
                                ? 'Wrong password.'
                                : 'Unknown error.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }, builder: (context, state) {
                    if (state.status == LoginStatus.connecting) {
                      return const Center(
                        child: CustomButton(
                            color: Color.fromARGB(255, 172, 167, 232),
                            text: 'Log In',
                            onPressed: null),
                      );
                    } else {
                      return Center(
                        child: CustomButton(
                          color: const Color(0xFF837ADD),
                          text: 'Log In',
                          onPressed: buttonEnabled
                              ? () {
                                  setState(() {
                                    buttonEnabled =
                                        false; // disable button when initiating login
                                  });
                                  context.read<LoginCubit>().login(
                                        loginController.text,
                                        passwordController.text,
                                      );
                                  //clear controllers in case of come back to the loginPage
                                  loginController.clear();
                                  passwordController.clear();
                                }
                              : null,
                        ),
                      );
                    }
                  }),
                  SizedBox(height: dh * .015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                        style:
                            suffix(dh * .014, Colors.grey, FontWeight.normal),
                      ),
                      Text(
                        "Create now",
                        style: suffix(dh * .014, Colors.black, FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void activateLoginButton() {
    final loginDataEntered =
        loginController.text.isNotEmpty && passwordController.text.isNotEmpty;

    setState(() {
      buttonEnabled = loginDataEntered;
    });
  }
}

TextStyle suffix(fontSize, color, fontWeight) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
