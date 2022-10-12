import 'package:flutter/material.dart';

import 'login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    this.inicioApp = true,
  }) : super(key: key);
  final bool inicioApp;

  @override
  LoginWidget createState() => LoginWidget();
}
