import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Cidade.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/empresa/empresa_service.dart';

class EmpresaController {
  final nomeController = TextEditingController();
  final cnpjController = TextEditingController();
  final telefone1Controller = TextEditingController();
  final telefone2Controller = TextEditingController();
  final enderecoController = TextEditingController();
  final numeroController = TextEditingController();
  final cepController = TextEditingController();
  final bairroController = TextEditingController();
  final logoBase64Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late Empresa empresa;

  MyPageTransition myPageTransition = MyPageTransition();
  File? image;
  PickedFile? pickedFile;
  bool imagemAlterada = false;
  String? logoBase64;
  Cidade? cidade;

  Future<Info?> buscarEmpresaEmail(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    Info info = Info(success: true);

    if (connected) {
      try {
        Token _token = await TokenRepository.findToken();
        info = await EmpresaService.buscaEmpresa(_token);
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

  Future<List<Cidade>> buscarCidadeFiltro(String? nomeCidade) async {
    try {
      Info info = await EmpresaService.buscarCidade(nomeCidade: nomeCidade);

      List<Cidade> cidadesRetorno = info.object;
      return cidadesRetorno;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
