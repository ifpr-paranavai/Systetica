import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/TokenDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/perfil/perfil_service.dart';

class PerfilController {
  File? image;
  PickedFile? pickedFile;
  String imagemBase64 = "";

  Future<UsuarioDTO?> buscarUsuarioEmail(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        TokenDTO _tokenDto = TokenDTO().toDTO(
          await TokenRepository.findToken(),
        );
        return await PerfilService.buscarUsuario(_tokenDto);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(
              mensagem: "Ocorreu algum erro ao buscar dados",
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
            mensagem: "Por Favor, conecte-se a rede para busca dados",
          ),
        ),
      );
    }
  }
}
