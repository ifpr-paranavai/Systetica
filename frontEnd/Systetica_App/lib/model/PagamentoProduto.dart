// ignore_for_file: file_names

import 'package:systetica/model/Produto.dart';

import 'Pagamento.dart';

class PagamentoProduto {
  PagamentoProduto({
    this.pagamento,
    this.produtos,
  });

  Pagamento? pagamento;
  List<Produto>? produtos;

  PagamentoProduto.fromJson(Map<String, dynamic> json) {
    pagamento = json['pagamento_produto'];
    produtos = Produto.fromJsonList(json['produtos']);
  }

  static List<PagamentoProduto> fromJsonList(List json) {
    return json.map((item) => PagamentoProduto.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagamento_produto'] = pagamento;
    _data['produtos'] = produtos;
    return _data;
  }
}
