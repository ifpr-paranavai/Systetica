import 'package:flutter/material.dart';

import '../../database/repository/token_repository.dart';
import '../../model/Token.dart';
import '../../utils/util.dart';
import '../home/view/home_page.dart';
import '../login/view/login/login_page.dart';

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
