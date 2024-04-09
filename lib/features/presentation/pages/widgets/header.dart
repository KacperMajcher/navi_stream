import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: dh * .06),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover',
                style: suffix(dh * .026, Colors.black, FontWeight.w800),
              ),
              Text(
                'Find your favourite movie',
                style:
                    suffix(dh * .019, const Color(0xFF565555), FontWeight.w400),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage('assets/noti_icon.png'),
            ),
          ),
        ],
      ),
    );
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
