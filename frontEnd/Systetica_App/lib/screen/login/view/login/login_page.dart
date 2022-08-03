import 'package:flutter/material.dart';
import 'package:systetica/screen/login/view/login/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    this.inicioApp = true,
  }) : super(key: key);
  final bool inicioApp;

  @override
  LoginWidget createState() => LoginWidget();
}
