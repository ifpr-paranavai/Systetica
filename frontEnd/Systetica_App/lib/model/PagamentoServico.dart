// ignore_for_file: file_names

import 'package:systetica/model/Servico.dart';

import 'Pagamento.dart';

class PagamentoServico {
  PagamentoServico({
    this.pagamento,
    this.servicos,
  });

  Pagamento? pagamento;
  List<Servico>? servicos;

  PagamentoServico.fromJson(Map<String, dynamic> json) {
    pagamento = json['pagamento'];
    servicos = Servico.fromJsonList(json['desconto']);
  }

  static List<PagamentoServico> fromJsonList(List json) {
    return json.map((item) => PagamentoServico.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagamento'] = pagamento;
    _data['servicos'] = servicos;
    return _data;
  }
}
