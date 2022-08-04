import 'package:flutter/material.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/screen/home/view/home_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';
import 'package:systetica/utils/util.dart';

class InicioController {
  Future<void> verificarDirecionamentoUsuario(BuildContext context) async {
    Token token = await TokenRepository.findToken();
    if (Util.isIntegerNull(token.id) ||
        Util.isEmptOrNull(token.accessToken) ||
        Util.isEmptOrNull(token.refreshToken)) {
      return;
    } else {
      DateTime dataToken = DateTime.parse(token.dateTimeToken!);
      DateTime dataAtual = DateTime.now();
      if (dataToken.day < dataAtual.day ||
          dataToken.month < dataAtual.month ||
          dataToken.year < dataAtual.year) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(inicioApp: false),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    }
  }
}
