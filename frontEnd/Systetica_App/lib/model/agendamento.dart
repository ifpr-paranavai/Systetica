// ignore_for_file: constant_identifier_names, file_names

import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/HorarioAgendamento.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/Usuario.dart';

class Agendamento {
  Agendamento({
    required this.empresa,
    required this.servicosSelecionados,
    required this.funcionario,
    this.usuario,
    required this.horarioAgendamento,
  });

  Empresa empresa;
  List<Servico> servicosSelecionados;
  Usuario funcionario;
  Usuario? usuario;
  HorarioAgendamento horarioAgendamento;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empresa'] = empresa;
    _data['servicos_selecionados'] = servicosSelecionados;
    _data['funcionario'] = funcionario;
    _data['usuario'] = usuario;
    _data['horario_agendamento'] = horarioAgendamento;
    return _data;
  }
}
