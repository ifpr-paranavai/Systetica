// ignore_for_file: file_names

import 'package:systetica/model/Produto.dart';

import 'Pagamento.dart';

class PagamentoServico {
  PagamentoServico({
    this.pagamento,
    this.produtos,
  });

  Pagamento? pagamento;
  List<Produto>? produtos;

  PagamentoServico.fromJson(Map<String, dynamic> json) {
    pagamento = json['pagamento'];
    produtos = Produto.fromJsonList(json['produtos']);
  }

  static List<PagamentoServico> fromJsonList(List json) {
    return json.map((item) => PagamentoServico.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagamento'] = pagamento;
    _data['produtos'] = produtos;
    return _data;
  }
}
