import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/texto_erro_widget.dart';
import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/page_transition.dart';
import '../../database/repository/token_repository.dart';
import '../../model/Empresa.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../model/DadosAgendamento.dart';
import '../../request/dio_config.dart';
import '../../utils/util.dart';
import '../home/view/home_page.dart';
import 'agendar_service.dart';

class AgendarController {
  final nomeController = TextEditingController();
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late Empresa empresa;

  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  double largura = 0;
  double altura = 0;

  Future<Info?> buscarEmpresas({
    required BuildContext context,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AgendarService.buscarEmpresas(
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }

  Future<Info?> buscarTodosAgendamentoPorDia({
    required DateTime dataSelecionada,
    required Empresa empresa,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AgendarService.buscarTodosAgendamentoPorDia(
        dataAgendamento: DateFormat('yyyy-MM-dd').format(dataSelecionada),
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    info.object = Util.criarTodoHorarioAgendamento(
      empresa: empresa,
      horariosMarcados: info.object,
      dataSelecionada: dataSelecionada,
    );

    return info;
  }

  Future<void> agendarHorario({
    required DadosAgendamento dadosAgendamento,
    required BuildContext context,
  }) async {
    Info info = Info(success: true);
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        Token _token = await TokenRepository.findToken();

        // Validar se é agendamento com usuário cliente ou não
        if (dadosAgendamento.agendamentoCliente == false) {
          if (formKey.currentState != null) {
            if (formKey.currentState?.validate() ?? true) {
              dadosAgendamento.nomeCliente = nomeController.text;
              // Loading apresentado na tela
              var contextLoading = context;
              var loading = ShowLoadingWidget.showLoadingLabel(
                contextLoading,
                "Aguarde...",
              );

              info = await AgendarService.agendarHorario(
                token: _token,
                dadosAgendamento: dadosAgendamento,
              );

              // Finaliza o loading na tela
              Navigator.pop(contextLoading, loading);
            }
          }
        } else {
          dadosAgendamento.cliente.email = _token.email;

          // Loading apresentado na tela
          var contextLoading = context;
          var loading = ShowLoadingWidget.showLoadingLabel(
            contextLoading,
            "Aguarde...",
          );

          info = await AgendarService.agendarHorario(
            token: _token,
            dadosAgendamento: dadosAgendamento,
          );

          // Finaliza o loading na tela
          Navigator.pop(contextLoading, loading);
        }

        var alertDialog = AlertDialogWidget();
        if (info.success!) {
          alertDialog.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Sucesso",
            descricao: info.message!,
            buttonText: "OK",
            onPressedOk: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            ),
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
            mensagem: "Por Favor, conecte-se a rede para salvar agendamento",
          ),
        ),
      );
    }
  }
}
