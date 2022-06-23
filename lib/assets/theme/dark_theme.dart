import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme() {
  const Color foregroundColor = Color.fromRGBO(245, 251, 239, 1);
  const Color backgroundColor = Color.fromRGBO(24, 31, 28, 1);
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.lato(fontSize: 25),
      backgroundColor: const Color.fromRGBO(123, 75, 148, 1),
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardTheme: CardTheme(
      color: backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: foregroundColor.withOpacity(0.7), width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: foregroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
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
