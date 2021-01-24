import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prozone/utils/utils.dart';


final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blueGrey[900],
  cursorColor: GREEN_HUE,
  accentColor: GREEN_HUE,
  fontFamily: GoogleFonts.lato().fontFamily,
  scaffoldBackgroundColor: LIGHT_BLUE_ACCENT,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.blueGrey[50],
  ),
);
