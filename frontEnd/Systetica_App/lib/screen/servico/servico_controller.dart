import 'package:flutter/material.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/servico_service.dart';

class ServicoController {
  late List<Servico> servicos = [];

  Future<Info?> buscarServico({
    required BuildContext context,
    required String servico,
  }) async {
    Info info = Info(success: true);

    try {
      info = await ServicoService.buscarServico(servico: servico);
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }
}
