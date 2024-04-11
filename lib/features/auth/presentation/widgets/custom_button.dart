import 'package:flutter/material.dart';
import 'package:navi_stream/utils/text_suffix.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    this.onPressed,
  });

  final Color color;
  final String text;
  final VoidCallback? onPressed;

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
            horizontal: dw * .39,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: suffix(
          dh * .0175,
          Colors.white,
          FontWeight.w600,
        ),
      ),
    );
  }
}
