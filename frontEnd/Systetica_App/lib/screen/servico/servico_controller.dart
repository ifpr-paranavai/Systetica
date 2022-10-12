import 'package:flutter/material.dart';
import 'package:systetica/screen/servico/servico_service.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/page_transition.dart';
import '../../components/texto_erro_widget.dart';
import '../../database/repository/token_repository.dart';
import '../../model/Info.dart';
import '../../model/Servico.dart';
import '../../model/Token.dart';
import '../../request/dio_config.dart';

class ServicoController {
  final nomeController = TextEditingController();
  final tempoServicoController = TextEditingController();
  final descricaoController = TextEditingController();
  final precoController = TextEditingController();
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Servico> servicos;
  late Servico servico;
  bool? status;

  Future<void> cadastrarServico(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          try {
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            Token _token = await TokenRepository.findToken();
            servico.nome = nomeController.text;
            servico.tempoServico = int.parse(tempoServicoController.text);
            servico.preco = double.parse(precoController.text);
            servico.descricao = descricaoController.text;
            servico.emailAdministrativo = _token.email;
            Info _info = await ServicoService.cadastrarServico(_token, servico);

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
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um serviço",
          ),
        ),
      );
    }
  }

  Future<void> atualizarServico(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          try {
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            Token _token = await TokenRepository.findToken();

            servico.nome = nomeController.text;
            servico.tempoServico = int.parse(tempoServicoController.text);
            servico.preco = double.parse(precoController.text);
            servico.descricao = descricaoController.text;
            servico.emailAdministrativo = _token.email;
            servico.status = status;

            Info _info = await ServicoService.atualizarServico(_token, servico);

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
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um serviço",
          ),
        ),
      );
    }
  }

  Future<Info?> buscarServico({
    required BuildContext context,
    required String servico,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await ServicoService.buscarServicos(
        servico: servico,
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }

  Future<Info?> buscarServicoPorId({
    required BuildContext context,
    required int id,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await ServicoService.buscarServicosPorId(
        id: id,
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }
}
