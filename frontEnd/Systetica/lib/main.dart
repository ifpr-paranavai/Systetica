import 'dart:io';

import 'package:flutter/material.dart';
import 'package:systetica/screen/autenticacao/inicio_page.dart';
import 'package:systetica/style/app_theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Systetica',
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: const SafeArea(
        child: InicioPage(),
      ),
    );
  }
}
