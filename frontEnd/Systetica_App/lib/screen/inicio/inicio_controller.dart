import 'package:flutter/material.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/TokenDTO.dart';
import 'package:systetica/screen/home/view/home_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';
import 'package:systetica/utils/util.dart';

class InicioController {
  Future<void> verificarDirecionamentoUsuario(BuildContext context) async {
    TokenDTO tokenDTO = await TokenRepository.findToken();
    if (Util.isIntegerNull(tokenDTO.id) ||
        Util.isEmptOrNull(tokenDTO.accessToken) ||
        Util.isEmptOrNull(tokenDTO.refreshToken)) {
      return;
    } else {
      DateTime dataToken = DateTime.parse(tokenDTO.dateTimeToken!);
      DateTime dataAtual = DateTime.now();
      if (dataToken.day < dataAtual.day ||
          dataToken.year < dataAtual.year ||
          dataToken.month < dataToken.month) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
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
