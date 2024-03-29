// ignore_for_file: file_names

import 'Servico.dart';
import 'Situacao.dart';
import 'Usuario.dart';

class Agendamento {
  Agendamento({
    this.id,
    this.nomeCliente,
    this.dataAgendamento,
    this.horarioAgendamento,
    this.servicos,
    this.situacao,
    this.cliente,
    this.funcionario,
  });

  int? id;
  String? nomeCliente;
  String? dataAgendamento;
  String? horarioAgendamento;
  List<Servico>? servicos;
  Situacao? situacao;
  Usuario? cliente;
  Usuario? funcionario;

  Agendamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeCliente = json['nome_cliente'];
    dataAgendamento = json['data_agendamento'];
    horarioAgendamento = json['horario_agendamento'];
    servicos = json['ass_servico_agendado'] != null
        ? (json['ass_servico_agendado']
            .map<Servico>((e) => Servico.fromJson(e))).toList()
        : [];
    situacao = Situacao.fromJson(json['situacao']);
    cliente =
        json['cliente'] != null ? Usuario.fromJson(json['cliente']) : null;
    funcionario = Usuario.fromJson(json['funcionario']);
  }

  static List<Agendamento> fromJsonList(List json) {
    return json.map((item) => Agendamento.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }
}
