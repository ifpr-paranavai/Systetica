import 'package:flutter/material.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/page_transition.dart';
import '../../components/texto_erro_widget.dart';
import '../../database/repository/token_repository.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../model/Usuario.dart';
import '../../request/dio_config.dart';
import 'ativar_funcionario_service.dart';

class AtivarFuncionarController {
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Usuario> usuarios;
  late Usuario usuario;

  Future<Info?> buscarFuncionarios(BuildContext context) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AtivarFuncionarioService.buscarFuncionarios(
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }

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

  Future<void> concederPermissao(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        Token _token = await TokenRepository.findToken();
        usuario.emailAdministrativo = _token.email;

        Info _info = await AtivarFuncionarioService.concederPermissao(
          _token,
          usuario,
        );

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        var alertDialogOk = AlertDialogWidget();
        if (_info.success!) {
          return;
        } else {
          alertDialogOk.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Erro",
            descricao: _info.message!,
            buttonText: "OK",
            onPressedOk: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(
              mensagem: "Ocorreu algum erro de comunicação com o servidor",
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para conceder permissão",
          ),
        ),
      );
    }
  }
}
