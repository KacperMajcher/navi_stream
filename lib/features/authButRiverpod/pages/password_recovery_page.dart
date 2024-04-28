import 'package:flutter/material.dart';
import 'package:navi_stream/features/authButRiverpod/widgets/custom_button.dart';
import 'package:navi_stream/features/authButRiverpod/widgets/login_input_field.dart';
import 'package:navi_stream/utils/custom_app_bar.dart';
import 'package:navi_stream/utils/text_suffix.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController emailController = TextEditingController();
  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(
      () {
        final emailNotEmpty = emailController.text.isNotEmpty;
        if (buttonEnabled != emailNotEmpty) {
          setState(
            () {
              buttonEnabled = emailNotEmpty;
            },
          );
        }
      },
    );
  }

  void sendEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email sent'),
        backgroundColor: Colors.green,
      ),
    );
    emailController.clear();
    setState(
      () {
        buttonEnabled = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    final double dh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dw * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: dh * .08),
            Text(
              'Forgot your password?',
              style: suffix(
                dh * .03,
                Colors.black,
                FontWeight.w700,
              ),
            ),
            SizedBox(height: dh * .01),
            Padding(
              padding: EdgeInsets.only(right: dw * .15),
              child: Text(
                'We\'ll send you a link that will sign you into the app instantly.',
                style: suffix(
                  dh * .02,
                  Colors.black,
                  FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: dh * .04),
            LoginInputField(
              controller: emailController,
              obscureText: false,
              hintText: 'Email',
            ),
            SizedBox(height: dh * .04),
            Center(
              child: CustomButton(
                color: buttonEnabled
                    ? const Color(0xFF837ADD)
                    : const Color(0xFFACA7E8),
                text: 'Send',
                onPressed: buttonEnabled ? sendEmail : null,
              ), // TODO: check the correctness of the email address
            ),
            SizedBox(height: dh * .015),
          ],
        ),
      ),
    );
  }
}
