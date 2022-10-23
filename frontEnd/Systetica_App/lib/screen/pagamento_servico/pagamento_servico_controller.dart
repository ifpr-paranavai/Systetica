import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/page_transition.dart';
import '../../components/texto_erro_widget.dart';
import '../../database/repository/token_repository.dart';
import '../../model/Agendamento.dart';
import '../../model/FormaPagamento.dart';
import '../../model/Info.dart';
import '../../model/Pagamento.dart';
import '../../model/PagamentoServico.dart';
import '../../model/Token.dart';
import '../../request/dio_config.dart';
import 'pagamento_servico_service.dart';

class PagamentoServicoController {
  final descontoController = TextEditingController();
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();

  late List<Agendamento> agendamentos = [];
  late PagamentoServico pagamentoServico = PagamentoServico();

  double largura = 0;
  double altura = 0;
  FormaPagamento? formaPagamento;

  Future<Info?> buscarTodosAgendamentoPorDiaStatusAgendados({
    required DateTime dataSelecionada,
  }) async {
    Info info = Info(success: true);
    try {
      Token _token = await TokenRepository.findToken();
      info = await PagamentoServicoService
          .buscarTodosAgendamentoPorDiaStatusAgendados(
        dataAgendamento: DateFormat('yyyy-MM-dd').format(dataSelecionada),
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }

    return info;
  }

  Future<void> cadastrarPagamentoServico({
    required BuildContext context,
    required Agendamento agendamento,
    required double valorTotal,
  }) async {
    if (await ConnectionCheck.check()) {
      if (formaPagamento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "Por favor, adicione forma de pagamento_produto",
            ),
          ),
        );
        return;
      }
      Info info = Info(success: true);
      try {
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        double desconto = descontoController.text.isEmpty
            ? 0
            : double.parse(descontoController.text);
        pagamentoServico.agendamento = agendamento;
        pagamentoServico.pagamento = Pagamento(
          formaPagamento: formaPagamento,
          desconto: desconto,
          valorTotal: valorTotal - desconto,
        );

        Token _token = await TokenRepository.findToken();

        info = await PagamentoServicoService.cadastrarPagamentoServico(
          token: _token,
          pagamentoServico: pagamentoServico,
        ); // service

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        var alertDialog = AlertDialogWidget();
        if (info.success!) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blueGrey,
              content: TextoErroWidget(
                mensagem: info.message!,
              ),
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
            mensagem:
                "Por Favor, conecte-se a rede para cadastrar um pagamento_produto",
          ),
        ),
      );
    }
  }
}
