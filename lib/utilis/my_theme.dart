import 'package:covometer/utilis/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myCustomThemeData(BuildContext context) {
  return ThemeData(
      textTheme: TextTheme(
          headline1: GoogleFonts.rubik(
            textStyle: TextStyle(
                color: kWhite, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          headline2: GoogleFonts.rubik(
              textStyle: TextStyle(
            color: kBackgroundColor,
          ))));
}
