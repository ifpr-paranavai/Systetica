import 'package:flutter/material.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/screen/ativar_funcionario/ativar_funcionario_service.dart';

class AtivarFuncionarController {
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Usuario> usuarios;

  Future<Info?> buscarUsuarios({
    required BuildContext context,
    required String usuario,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AtivarFuncionarioService.buscaUsuarios(
        usuarioBusca: usuario,
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }
}