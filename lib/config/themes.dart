import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.red,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.red,
        fontSize: 30.0,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 30.0,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 25.0,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
    hintColor: Colors.black.withOpacity(0.6),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontStyle: FontStyle.italic,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.6)),
      ),
      border: OutlineInputBorder(),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: BorderSide(color: Colors.black.withOpacity(0.6)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: Colors.red,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.red,
        fontSize: 30.0,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 25.0,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    ),
    hintColor: Colors.white60,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontStyle: FontStyle.italic,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white60),
      ),
      border: OutlineInputBorder(),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: BorderSide(color: Colors.white60),
      ),
    ),
  );
}
