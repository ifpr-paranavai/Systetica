import 'package:flutter/material.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/screen/agendar/agendar_service.dart';

class AgendarController {
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Empresa> empresas = [];
  late List<Servico> servicos = [];
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
}
