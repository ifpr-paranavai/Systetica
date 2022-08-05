import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/alert_dialog_widget.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Cidade.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
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

  Future<void> atualizarEmpresa(BuildContext context) async {
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

        empresa.nome = nomeController.text;
        empresa.telefone1 = telefone1Controller.text;
        empresa.telefone2 = telefone2Controller.text;
        empresa.endereco = enderecoController.text;
        empresa.numero = int.parse(numeroController.text);
        empresa.cep = cepController.text;
        empresa.bairro = bairroController.text;
        empresa.logoBase64 = logoBase64;
        //Todo adicionar sobre cidade

        Token _token = await TokenRepository.findToken();
        Info _info = await EmpresaService.atualizarEmpresa(_token, empresa);
        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        if (_info.success!) {
          Navigator.pop(context);
        } else {
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
              mensagem: "Ocorreu algum erro para editar empresa",
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
            mensagem: "Por Favor, conecte-se a rede para atualizar empresa",
          ),
        ),
      );
    }
  }
}
