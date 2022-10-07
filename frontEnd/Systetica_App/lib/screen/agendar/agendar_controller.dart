import 'package:flutter/material.dart';
import 'package:systetica/components/alert_dialog_widget.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/model/agendamento.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/agendar/agendar_service.dart';
import 'package:systetica/screen/agendar/view/empresas/empresa_agendar_page.dart';
import 'package:systetica/utils/util.dart';
import 'package:intl/intl.dart';

class AgendarController {
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Empresa> empresas = [];
  late Empresa empresa;
  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  double largura = 0;
  double altura = 0;

  Future<Info?> buscarEmpresas({
    required BuildContext context,
    required String nomeEmpresa,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AgendarService.buscarEmpresas(
        token: _token,
        nomeEmpresa: nomeEmpresa,
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
    required Agendamento agendamento,
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
        agendamento.cliente.email = _token.email;

        info = await AgendarService.agendarHorario(
          token: _token,
          agendamento: agendamento,
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
            onPressedOk: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const EmpresaAgendarPage(),
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
