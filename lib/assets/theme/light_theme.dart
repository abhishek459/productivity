import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  const Color foregroundColor = Color.fromRGBO(24, 31, 28, 1);
  const Color backgroundColor = Color.fromRGBO(251, 249, 255, 1);
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color.fromRGBO(123, 75, 148, 1),
    ),
    scaffoldBackgroundColor: backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: foregroundColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: foregroundColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      counterStyle: const TextStyle(color: foregroundColor),
      suffixIconColor: foregroundColor,
    ),
    splashColor: backgroundColor,
    hintColor: foregroundColor,
    textTheme: TextTheme(
      displayMedium: GoogleFonts.notoSans(
        color: foregroundColor,
        fontSize: 18,
      ),
    ),
  );
}
