import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle suffix(
  fontSize,
  color,
  fontWeight,
) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
