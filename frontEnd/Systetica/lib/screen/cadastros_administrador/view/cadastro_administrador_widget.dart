import 'package:flutter/material.dart';
import 'package:systetica/screen/cadastros_administrador/view/cadastro_administrador_page.dart';

class CadastroAdministradorWidget extends State<CadastroAdministradorPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink,
        body: Text("Cadastro Administrador"),
      ),
    );
  }
}
