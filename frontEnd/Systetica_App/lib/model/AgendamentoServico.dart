// ignore_for_file: file_names

import 'package:systetica/model/Usuario.dart';
import 'package:systetica/model/Situacao.dart';

class AgendamentoServico {
  AgendamentoServico({
    this.id,
    this.nomeCliente,
    this.dataAgendamento,
    this.horarioAgendamento,
    this.situacao,
    this.cliente,
  });

  int? id;
  String? nomeCliente;
  String? dataAgendamento;
  String? horarioAgendamento;
  Situacao? situacao;
  Usuario? cliente;

  AgendamentoServico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeCliente = json['nome_cliente'];
    dataAgendamento = json['data_agendamento'];
    horarioAgendamento = json['horario_agendamento'];
    situacao = Situacao.fromJson(json['situacao']);
    cliente = Usuario.fromJson(json['cliente']);
  }

  static List<AgendamentoServico> fromJsonList(List json) {
    return json.map((item) => AgendamentoServico.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome_cliente'] = nomeCliente;
    _data['data_agendamento'] = dataAgendamento;
    _data['horario_agendamento'] = horarioAgendamento;
    _data['situacao'] = situacao;
    _data['cliente'] = cliente;
    return _data;
  }
}
