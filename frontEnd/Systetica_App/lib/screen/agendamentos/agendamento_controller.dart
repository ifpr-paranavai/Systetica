import 'package:flutter/material.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/AgendamentoServico.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/screen/agendamentos/agendamento_service.dart';
import 'package:intl/intl.dart';

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
}
