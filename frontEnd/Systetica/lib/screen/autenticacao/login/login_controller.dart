import 'package:flutter/material.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/orm/token_orm.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/autenticacao/login/login_service.dart';
import 'package:systetica/screen/home/view/home_page.dart';
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
      //Loading apresentado na tela
      var contextLoading = context;
      var loading = ShowLoadingWidget.showLoadingLabel(
        contextLoading,
        "Aguarde...",
      );
      try {
        LoginDTO login = LoginDTO(
          email: emailController.text,
          password: senhaController.text,
        );
        var tokenDto = await LoginService.login(login);

        // Verificar se já existe alguma Usuario cadastrado no banco
        TokenORM existeTokenORM = await TokenRepository.findToken();

        if(Validacoes.isIntegerNull(existeTokenORM.id) && Validacoes.isEmptOrNull(existeTokenORM.accessToken) &&  Validacoes.isEmptOrNull(existeTokenORM.refreshToken)) {
          TokenRepository.insertToken(tokenDto!);
        } else {
          existeTokenORM.id = existeTokenORM.id;
          TokenRepository.updateToken(existeTokenORM);
        }

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      } catch (e) {
        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(mensagem: "Usuário ou senha incorreto")));
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
