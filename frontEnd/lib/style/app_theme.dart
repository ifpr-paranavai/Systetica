import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData.dark().copyWith(
  cardTheme: CardTheme(
    elevation: 3.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  toggleableActiveColor: Colors.amber[800],
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.amber[800],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.amber[800],
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(
        Colors.amber[800]?.withOpacity(0.1),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blueGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(0),
      ),
    ),
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    onPrimary: Colors.white,
    primary: Colors.blueGrey,
    secondary: Colors.amber.shade800,
    onSecondary: Colors.white,
  ),
);
