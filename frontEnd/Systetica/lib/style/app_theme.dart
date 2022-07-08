import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primarySwatch: createMaterialColor(Colors.black87.withOpacity(0.9)),
  brightness: Brightness.light,
  dataTableTheme: DataTableThemeData(
    headingRowHeight: 45.0,
    dataRowHeight: 45.0,
    headingRowColor: MaterialStateProperty.all(const Color(0xffcc00fd)),
    headingTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    checkboxHorizontalMargin: 20,
    dividerThickness: 0,
    columnSpacing: 10,
  ),
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
