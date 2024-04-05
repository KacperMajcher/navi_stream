import 'package:flutter/material.dart';
import 'package:navi_stream/features/presentation/pages/home_page.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const HomePage()));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
