import 'package:flutter/material.dart';
import 'package:navi_stream/utils/text_suffix.dart';

class LoginInputField extends StatefulWidget {
  const LoginInputField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  @override
  LoginInputFieldState createState() => LoginInputFieldState();
}

class LoginInputFieldState extends State<LoginInputField> {
  bool _isFieldActive = false;

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;

    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      maxLines: 1,
      onChanged: (value) {
        setState(() {
          _isFieldActive = value.isNotEmpty;
        });
      },
      style: suffix(
        dh * .0175,
        const Color(0xff053630),
        FontWeight.w400,
      ),
      decoration: InputDecoration(
        disabledBorder: InputBorder.none,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFDDD9D9),
            width: 2,
          ),
        ),
        labelText: _isFieldActive ? widget.hintText : null,
        hintText: _isFieldActive ? null : widget.hintText,
        hintStyle: suffix(
          dh * .0175,
          const Color(0x4A191918),
          FontWeight.w400,
        ),
      ),
    );
  }
}
