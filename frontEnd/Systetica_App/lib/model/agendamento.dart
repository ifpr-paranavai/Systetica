// ignore_for_file: constant_identifier_names, file_names

import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/HorarioAgendamento.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/Usuario.dart';

class Agendamento {
  Agendamento({
    required this.cliente,
    required this.funcionario,
    required this.empresa,
    required this.horarioAgendamento,
    required this.servicosSelecionados,
  });

  Usuario cliente;
  Usuario funcionario;
  Empresa empresa;
  HorarioAgendamento horarioAgendamento;
  List<Servico> servicosSelecionados;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cliente_email'] = cliente.email;
    _data['funcionario_id'] = funcionario.id;
    _data['empresa_id'] = empresa.id;
    _data['horario_agendamento'] = horarioAgendamento.toJson();
    _data['servicos_selecionados'] = servicosSelecionados.map((i) => i.toJson()).toList();
    return _data;
  }
}
