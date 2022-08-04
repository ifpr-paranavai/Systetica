import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/alert_dialog_widget.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/perfil/perfil_service.dart';

class PerfilController {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late Usuario usuario;

  var myPageTransition = MyPageTransition();

  File? image;
  PickedFile? pickedFile;
  bool imagemAlterada = false;
  String? imagemBase64;

  Future<Info?> buscarUsuarioEmail(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    Info info = Info(success: true);
    if (connected) {
      try {
        Token _token = await TokenRepository.findToken();
        info = await PerfilService.buscarUsuario(_token);
        return info;
      } catch (e) {
        info.success = false;
        return info;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para busca dados",
          ),
        ),
      );
      return info;
    }
  }

  Future<void> atualizarUsuarioEmail(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      Info info = Info(success: true);
      try {
        // Loading apresentado na tela
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        usuario.nome = nomeController.text;
        usuario.telefone = telefoneController.text;
        usuario.imagemBase64 = imagemBase64;

        Token _token = await TokenRepository.findToken();
        Info _info = await PerfilService.atualizarUsuario(_token, usuario);
        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        if(_info.success! ){
          Navigator.pop(context);
        } else  {
          var alertDialogOk = AlertDialogWidget();
          alertDialogOk.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Erro",
            descricao: info.message!,
            buttonText: "OK",
            onPressedOk: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(
              mensagem: "Ocorreu algum erro para editar perfil",
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
            mensagem: "Por Favor, conecte-se a rede para atualizar usuário",
          ),
        ),
      );
    }
  }
}
