import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });
  final Color color;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    final double dh = MediaQuery.of(context).size.height;

    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: dh * .01,
            horizontal: dw * .4,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: dh * .0175,
          ),
        ),
      ),
    );
  }
}

