import 'package:flutter/material.dart';
import 'package:navi_stream/features/authButRiverpod/pages/login_page.dart';
import 'package:navi_stream/features/authButRiverpod/widgets/custom_button.dart';
import 'package:navi_stream/utils/text_suffix.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: dh * .07),
          Image.asset(
            'assets/navistream_logo/logo_purple.png',
            height: dh * .1,
          ),
          Center(
            child: Text(
              'Your seamless navigation\nto endless entertainment!',
              style: suffix(
                dh * .023,
                Colors.black,
                FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: dh * .1),
          Image.asset('assets/background_images/welcome_page.png'),
          SizedBox(height: dh * .2),
          CustomButton(
            color: const Color(0xFF837ADD),
            text: 'Log In',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
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
              Text(
                "Create now",
                style: suffix(
                  dh * .014,
                  Colors.black,
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
