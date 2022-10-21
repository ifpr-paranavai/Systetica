// ignore_for_file: constant_identifier_names, file_names

import 'Empresa.dart';
import 'HorarioAgendamento.dart';
import 'Servico.dart';
import 'Usuario.dart';

class DadosAgendamento {
  DadosAgendamento({
    required this.cliente,
    required this.funcionario,
    required this.empresa,
    required this.horarioAgendamento,
    required this.servicosSelecionados,
    this.agendamentoCliente = true,
    this.nomeCliente,
  });

  Usuario cliente;
  Usuario funcionario;
  Empresa empresa;
  HorarioAgendamento horarioAgendamento;
  List<Servico> servicosSelecionados;
  bool agendamentoCliente;
  String? nomeCliente;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cliente_email'] = cliente.email;
    _data['funcionario_id'] = funcionario.id;
    _data['empresa_id'] = empresa.id;
    _data['horario_agendamento'] = horarioAgendamento.toJson();
    _data['servicos_selecionados'] =
        servicosSelecionados.map((i) => i.toJson()).toList();
    _data['nome_cliente'] = nomeCliente;
    return _data;
  }
}
