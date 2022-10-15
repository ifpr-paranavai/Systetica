import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:systetica/model/FormaPagamento.dart';

import '../../components/page_transition.dart';
import '../../database/repository/token_repository.dart';
import '../../model/Agendamento.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import 'pagamento_servico_service.dart';

class PagamentoServicoController {
  final descontoController = TextEditingController();
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();

  late List<Agendamento> agendamentos = [];

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

  Future<List<FormaPagamento>> buscarFormaPamento(String? nome) async {
    try {
      Token _token = await TokenRepository.findToken();
      Info info = await PagamentoServicoService.buscarFormaPagamento(
        token: _token,
        nome: nome,
      );
      return info.object;
    } catch (e) {
      return [];
    }
  }
}
