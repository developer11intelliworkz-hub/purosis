import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      textTheme: GoogleFonts.interTextTheme(),
    );
  }
}
