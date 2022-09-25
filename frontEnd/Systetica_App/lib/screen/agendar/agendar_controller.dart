import 'package:flutter/material.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/screen/agendar/agendar_service.dart';
import 'package:systetica/utils/util.dart';

class AgendarController {
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Empresa> empresas = [];
  late Empresa empresa;

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
    required String dataAgendamento,
    required Empresa empresa,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await AgendarService.buscarTodosAgendamentoPorDia(
        dataAgendamento: dataAgendamento,
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    info.object = Util.criarTodoHorarioAgendamento(
      empresa: empresa,
      horariosMarcados: info.object,
    );

    return info;
  }
}
