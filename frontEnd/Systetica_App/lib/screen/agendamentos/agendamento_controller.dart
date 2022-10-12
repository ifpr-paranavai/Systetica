import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/texto_erro_widget.dart';
import '../../components/page_transition.dart';
import '../../database/repository/token_repository.dart';
import '../../model/AgendamentoServico.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../request/dio_config.dart';
import 'agendamento_service.dart';

class AgendamentoController {
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();

  late List<AgendamentoServico> agendamentos = [];

  double largura = 0;
  double altura = 0;

  Future<Info?> buscarTodosAgendamentoPorDia({
    required DateTime dataSelecionada,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AgendamentoService.buscarTodosAgendamentoPorDiaEmail(
        dataAgendamento: DateFormat('yyyy-MM-dd').format(dataSelecionada),
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }

    return info;
  }

  Future<void> cancelarAgendamento({
    required AgendamentoServico agendamentoServico,
    required BuildContext context,
  }) async {
    Info info = Info(success: true);
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        // Loading apresentado na tela
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        Token _token = await TokenRepository.findToken();

        info = await AgendamentoService.cancelarAgendamento(
          agendamentoServico: agendamentoServico,
          token: _token,
        );

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        var alertDialog = AlertDialogWidget();
        if (info.success!) {
          alertDialog.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Sucesso",
            descricao: info.message!,
            buttonText: "OK",
            onPressedOk: () => Navigator.pop(context),
          );
        } else {
          await alertDialog.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Erro",
            descricao: info.message!,
            buttonText: "OK",
            onPressedOk: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        info.success = false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cancelar agendamento",
          ),
        ),
      );
    }
  }
}
