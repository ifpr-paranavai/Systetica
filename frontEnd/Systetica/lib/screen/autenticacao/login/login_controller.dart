import 'package:flutter/material.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/autenticacao/login/login_service.dart';
import 'package:systetica/utils/validacoes.dart';

class LoginController {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  login(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (Validacoes.isEmptOrNull(emailController.text) ||
          Validacoes.isEmptOrNull(senhaController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(18),
          content:
              TextoErroWidget(mensagem: "Por Favor, preencha todos os campos"),
        ));
        return;
      }
      try {
        LoginDTO login = LoginDTO(email: emailController.text, password: senhaController.text);

        var usuario = await LoginService.login(login);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(
                mensagem: "Ocorreu algum erro de comunicação com o servidor")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blueGrey,
        padding: EdgeInsets.all(12),
        content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um usuário"),
      ));
    }
  }
}
