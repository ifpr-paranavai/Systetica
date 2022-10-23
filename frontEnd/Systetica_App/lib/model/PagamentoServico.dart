// ignore_for_file: file_names

import 'Agendamento.dart';
import 'Pagamento.dart';

class PagamentoServico {
  PagamentoServico({
    this.pagamento,
    this.agendamento,
  });

  Pagamento? pagamento;
  Agendamento? agendamento;

  PagamentoServico.fromJson(Map<String, dynamic> json) {
    pagamento = json['pagamento_produto'];
    agendamento = Agendamento.fromJson(json['agendamento']);
  }

  static List<PagamentoServico> fromJsonList(List json) {
    return json.map((item) => PagamentoServico.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagamento_produto'] = pagamento;
    _data['agendamento'] = agendamento;
    return _data;
  }
}
